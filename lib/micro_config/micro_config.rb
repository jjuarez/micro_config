# encoding:UTF-8
require 'yaml'

#
# = MicroConfig - support for a basic yaml configuration
module MicroConfig
  extend self

  @config = {}

  def symbolize(object)
    case object
    when Hash
      object.inject({}) do |memo, (k, v)|
        memo.tap { |m| m[k.to_sym] = symbolize(v) }
      end
    when Array
      object.map { |v| symbolize(v) }
    else
      object
    end
  end

  def to_h
    @config
  end

  def [](key)
    @config[key]
  end

  def []=(key, value)
    @config[key.to_sym] = symbolize(value)
  end

  def fetch(key, default = nil)
    @config.fetch(key, default)
  end

  def configure(source = nil, options = {}, &_block)
    if options[:environment]
      case source
      when /\.(yml|yaml)$/i
        file_config        = YAML.load_file(source)
        environment_config = file_config.fetch(options[:environment].to_s)

        @config.merge!(symbolize(environment_config))
      when Hash
        hash_config = source.fetch(options[:environment].to_s)

        @config.merge!(symbolize(hash_config))
      else
        yield self if block_given?
      end
    else
      case source
      when /\.(yml|yaml)$/i
        @config.merge!(symbolize(YAML.load_file(source)))
      when Hash
        @config.merge!(symbolize(source))
      else
        yield self if block_given?
      end
    end
  rescue => ce
    raise("Problems loading config source: #{source}: (#{ce.message})")
  end

  def method_missing(method, *arguments, &_block)
    clean_method = method.to_s

    case clean_method
    when /(.+)=$/
      key          = clean_method.delete('=').to_sym
      @config[key] = arguments.size == 1 ? arguments[0] : arguments
    when /(.+)\?$/
      key = clean_method.delete('?').to_sym

      @config.keys.include?(key)
    else
      key = clean_method.to_sym

      @config.fetch(key)
    end
  end
end
