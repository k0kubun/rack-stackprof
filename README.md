# Rack::Stackprof

Periodically dump StackProf profile result to /tmp with easy-to-understand filename

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
Rails.application.middleware.use Rack::Stackprof
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
