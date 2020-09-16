require 'stackprof'
require 'rack/stackprof/version'

class Rack::Stackprof
  def initialize(app, options = {})
    @app = app
    @profile_interval_seconds = options.fetch(:profile_interval_seconds)
    @sampling_interval_microseconds = options.fetch(:sampling_interval_microseconds)
    @last_profiled_at = nil
    @result_directory = options.fetch(:result_directory) # for `StackProf::Middleware.save`
  end

  def call(env)
    # Profile every X seconds (not everytime) to prevent from consuming disk excessively
    profile_every(seconds: @profile_interval_seconds, env: env) do
      @app.call(env)
    end
  end

  private

  def profile_every(seconds:, env:, &block)
    if @last_profiled_at.nil? || @last_profiled_at < Time.now - seconds
      @last_profiled_at = Time.now
      with_profile(env) { block.call }
    else
      block.call
    end
  end

  def with_profile(env)
    started_at = Process.clock_gettime(Process::CLOCK_MONOTONIC, :float_microsecond)
    StackProf.start(mode: :wall, interval: @sampling_interval_microseconds)
    yield
  ensure
    StackProf.stop
    finished_at = Process.clock_gettime(Process::CLOCK_MONOTONIC, :float_microsecond)

    StackProf::Middleware.path = File.join(@result_directory, result_filename(env: env, duration_milliseconds: (finished_at - started_at) / 1000))
    StackProf::Middleware.save
  end

  # ex: "stackprof-20171004_175816-41860-GET_v1_users-0308ms.dump"
  def result_filename(env:, duration_milliseconds:)
    "stackprof-#{Time.now.strftime('%Y%m%d_%H%M%S')}-#{Process.pid}-#{env['REQUEST_METHOD']}#{env['REQUEST_PATH'].gsub(/[^\w]/, '_')}-#{'%04d' % duration_milliseconds.to_i}ms.dump"
  end
end
