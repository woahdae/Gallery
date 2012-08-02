module Gallery
  def self.settings
    Settings.instance
  end

  class Settings < BasicObject
    # so we can reference classes w/o appending '::'
    def self.const_missing(name)
      ::Object.const_get(name)
    end

    include Singleton

    def initialize
      config_dir = "#{File.expand_path(File.dirname(__FILE__))}/../config"

      settings = YAML.load(ERB.new(IO.read("#{config_dir}/settings.yml")).result)

      host_settings = "#{config_dir}/settings.host.yml"
      if File.exist?(host_settings)
        require 'socket'

        host_settings = YAML.load(ERB.new(IO.read(host_settings)).result)
        hostname = Socket.gethostname
        # load host specific config
        if (host_settings.has_key?(Rails.env) &&
            host_settings[Rails.env].has_key?(hostname))

          settings[Rails.env] ||= {}
          settings[Rails.env].deep_merge!(host_settings[Rails.env][hostname])
        end
      end

      if File.exists?("#{config_dir}/settings.yml.local")
        settings.deep_merge!(YAML.load(ERB.new(
          IO.read("#{config_dir}/settings.yml.local")).result))
      end

      @values = HashObj.from_hash(override_with_env(
        settings['defaults'].deep_merge(settings[Rails.env])))
    end

    def override_with_env(settings, path = [])
      settings.each_pair do |key, value|
        if value.is_a?(Hash)
          override_with_env(value, (path.dup << key.upcase))
        else
          settings[key] = ENV[(path.dup << key.upcase).join('_')] || value
        end
      end
    end
    private :override_with_env

    def [](key)
      @values[key]
    end

    def []=(key, value)
      @values[key] = value
    end

    def method_missing(key, value = nil)
      if value && @values[key]
        self[key] = value
      else
        self[key]
      end
    end

    class HashObj < BasicObject
      def initialize(*args)
        @data = ::HashWithIndifferentAccess.new(*args)
      end

      def self.from_hash(hash)
        hobj = new
        hash.each_pair do |key, value|
          hobj[key] = value
        end
        hobj
      end

      def []=(key, value)
        if value.is_a?(::Hash) && !value.is_a?(HashObj)
          # See HashWithIndifferentAccess for where these methods come from
          current = @data[key]
          if current && current.is_a?(::Hash)
            current = current.deep_merge(value)
          end

          @data.regular_writer(@data.send(:convert_key, key),
                               HashObj.from_hash(current || value))
        else
          @data[key] = value
        end
      end

      def [](key)
        @data[key]
      end

      def inspect
        @data.inspect
      end

      def keys
        @data.keys
      end

      def values
        @data.values
      end

      def to_s
        @data.to_s
      end

      def __data__
        @data
      end

      def deep_merge(other)
        @data.deep_merge(other)
      end

      def is_a?(klass)
        [::Hash, ::HashWithIndifferentAccess, HashObj].include?(klass)
      end

      def method_missing(key, value = nil)
        if value && @data[key]
          @data[key.to_s.gsub('=','')] = value
        else
          @data[key]
        end
      end
    end
  end
end
