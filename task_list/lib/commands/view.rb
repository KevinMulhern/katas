require_relative 'view_by/project'
require_relative 'view_by/deadline'

module Commands
  class View

    def initialize(output:, projects:, params:)
      @output = output
      @projects = projects
      @command = params.split(' ', 2).last
    end

    def self.execute(**args)
      new(args).execute
    end

    def execute
      begin
        command_obj = Commands::ViewBy.const_get(command.capitalize)
      rescue NameError
        @output.printf("I don't know what the command \"%s\" is.\n", command)
      else
        command_obj.public_send(:execute, output: @output, projects: @projects)
      end
    end

    private

    attr_reader :output, :projects, :command
  end
end
