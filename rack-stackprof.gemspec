lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/stackprof/version'

Gem::Specification.new do |spec|
  spec.name          = 'rack-stackprof'
  spec.version       = Rack::Stackprof::VERSION
  spec.authors       = ['Takashi Kokubun']
  spec.email         = ['takashikkbn@gmail.com']

  spec.summary       = %q{Periodically dump StackProf profile result to tmp directory with easy-to-understand filename}
  spec.description   = %q{Periodically dump StackProf profile result to tmp directory with easy-to-understand filename}
  spec.homepage      = 'https://github.com/k0kubun/rack-stackprof'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'stackprof'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
