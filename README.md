# Rack::ActiveRecordReconnector

A Rack middleware for cleaning ActiveRecord connection when raised Exception.

Mainly, Useful with Rack::Timeout.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-activerecord-reconnector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-activerecord-reconnector

## Usage

### Rails app

```ruby
config.middleware.use Rack::ActiveRecordReconnector
```

### Rack app

```ruby
Rack::Builder.new do
  use Rack::ActiveRecordReconnector
  run Rack::Application
end
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
