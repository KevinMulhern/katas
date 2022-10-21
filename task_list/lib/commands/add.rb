require_relative 'add_project'
require_relative 'add_task'

module Commands
  class Add

    def initialize(output:, projects:, params:)
      @output = output
      @projects = projects
      @params = Params.new(params)
    end

    def self.execute(**args)
      new(args).execute
    end

    def execute
      if params.project?
        AddProject.execute(projects: projects, name: params.name)
      elsif params.task?
        AddTask.execute(
          projects: projects,
          project_name: params.project_name,
          name: params.name,
          output: output
        )
      end
    end

    private

    attr_reader :output, :projects, :params

    class Params
      def initialize(params)
        @params = params.split(' ', 3)
      end

      def name
        @params.last
      end

      def project_name
        @params[1]
      end

      def task?
        @params.first == 'task'
      end

      def project?
        @params.first == 'project'
      end
    end
  end
end
