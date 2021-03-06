# MicroConfig

The purpose of the tiny gem is to provide a basic way to support YAML configuration in standalone applications

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'micro_config'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install micro_config

## Usage

#### Configure your application from a block
```ruby
require 'micro_config'
	
# Configure a bunch of keys in a block
MicroConfig.configure do |config|
  config.key         = 'My value'
  config.another_key = 'Another value'
  #...
end
	
# Test these keys
MicroConfig.key?
MicroConfig.this_not_exist?
	
# Set new values for your keys
MicroConfig.key = 'The new value'
	
# Of course, complex values are allowed
MicroConfig.super_complex_config = Struct.new('Person', :name, :type) 
```

#### Configure your appication from a hash
```ruby
require 'micro_config'
	
MicroConfig.configure(key: "Value", another_key: 'Other value')
```
#### Configure your appication from a file
```ruby
require 'micro_config'
	
MicroConfig.configure('/opt/my_app/config/application.yaml')
# and you can use the form of... you know
MicroConfig.configure('/opt/my_app/config/application.yaml', environment: :production)
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on the [Github repository](https://github.com/jjuarez/micro_config). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
