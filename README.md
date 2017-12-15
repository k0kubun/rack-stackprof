# Rack::Stackprof

Periodically dump StackProf profile result to `tmp` with easy-to-understand filenames

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-stackprof'
```

And then execute:

```bash
$ bundle
```

## Usage

```rb
if ENV['STACKPROF_ENABLE'] == 'true'
  Rails.application.middleware.use(
    Rack::Stackprof,
    profile_interval_seconds: 1,
    sampling_interval_microseconds: 1000,
    result_directory: 'tmp',
  )
end
```

After starting application with environment variable `STACKPROF_ENABLE=true`,
files whose name is like following ones will be periodically (once per second as `profile_interval_seconds: 1`) dumped to `tmp`.

```
stackprof-20171004_175816-41860-GET_v1_users-0308ms.dump
stackprof-20171004_175924-41860-GET_v1_accounts-0248ms.dump
stackprof-20171004_175955-41860-GET_v1_comments-1029ms.dump
...
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
