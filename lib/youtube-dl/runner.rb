module YoutubeDL
  # Utility class for running and managing youtube-dl
  class Runner
    include YoutubeDL::Support

    # @return [String] URL to download
    attr_accessor :url

    # @return [YoutubeDL::Options] Options access.
    attr_accessor :options

    # @return [String] Executable path
    attr_reader :executable_path

    # @return [String] Executable name to use
    attr_accessor :executable

    # Command Line runner initializer
    #
    # @param url [String] URL to pass to youtube-dl executable
    # @param options [Hash, Options] options to pass to the executable. Automatically converted to Options if it isn't already
    def initialize(options = {}, cmd)
      @cmd = cmd
      @options = YoutubeDL::Options.new(options)
      @executable = 'youtube-dl'
    end

    # Returns usable executable path for youtube-dl
    #
    # @return [String] usable executable path for youtube-dl
    def executable_path
      @executable_path ||= usable_executable_path_for(@executable)
    end

    # Returns the command string without running anything
    #
    # @return [String] command line string
    def to_command
      options_to_commands.join(' ')
    end
    alias_method :command, :to_command

    # Runs the command
    #
    # @return [String] the output of youtube-dl
    def run
      # debugger
      command = options_to_commands[0] + " " +  @cmd
      IO.popen(command)
    end
    alias_method :download, :run

    # Options configuration.
    # Just aliases to options.configure
    #
    # @yield [config] options
    # @param a [Array] arguments to pass to options#configure
    # @param b [Proc] block to pass to options#configure
    def configure(*a, &b)
      options.configure(*a, &b)
    end

    private

    # Parses options and converts them to Cocaine's syntax
    #
    # @return [String] commands ready to do cocaine
    def options_to_commands
      commands = []
      @options.sanitize_keys.each_paramized_key do |key, paramized_key|
        if @options[key].to_s == 'true'
          commands.push "--#{paramized_key}"
        elsif @options[key].to_s == 'false'
          commands.push "--no-#{paramized_key}"
        elsif @options[key].to_s == '-'
          commands.push "--#{paramized_key}"
        else
          commands.push "--#{paramized_key} :#{key}"
        end
      end
      commands.unshift executable_path
      commands
    end
  end
end