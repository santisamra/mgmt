class Configuration

  class InitializeDSL

    def self.optional_attr(attribute)
      define_method(attribute) { |value| @config[attribute] = value }
    end 

    optional_attr :base_local_path 
    optional_attr :base_global_path 
    optional_attr :prefix
    optional_attr :use_env_variables

    def initialize(&block)
      @config = {}
      instance_eval(&block)
    end

    def [](attribute)
      @config[attribute]
    end

  end

  attr_reader :config_file_name

  def initialize(config_file_name, &block)
    dsl = InitializeDSL.new(&block)
    @config_file_name = config_file_name
    @base_local_path = dsl[:base_local_path] || './'
    @base_global_path = dsl[:base_global_path] || '/'
    @prefix = dsl[:prefix]
    @use_env_variables = dsl[:use_env_variables] || true
  end

  def local_config_path 
    @local_config_path ||= config_path(@base_local_path)
  end

  def global_config_path 
    @global_config_path ||= config_path(@base_global_path)
  end

  def [](name)
    env_name = ''
    env_name << "#{@prefix.upcase}_" if @prefix
    env_name << name.upcase
    if @use_env_variables && ENV[env_name]
      ENV[env_name]
    else
      config[name]
    end
  end

  private

    def config
      return @config if @config

      @config = 
        if File.exist?(local_config_path)
          YAML.load_file(local_config_path)
        elsif File.exist?(global_config_path)
          YAML.load_file(global_config_path)
        else
          {}
        end
    end

    def config_path(base_path)
      File.expand_path(File.join(base_path, config_file_name))
    end

end