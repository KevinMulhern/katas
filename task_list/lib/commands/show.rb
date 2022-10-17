module Commands
  class Show
    def initialize(output:, projects:)
      @output = output
      @projects = projects
    end

    def self.execute(**args)
      new(output: args.fetch(:output), projects: args.fetch(:projects)).execute
    end

    def execute
      projects.each do |project|
        output.puts project.name

        project.tasks.each do |task|
          output.printf("  [%c] %d: %s\n", (task.done? ? 'x' : ' '), task.id, task.description)
        end

        output.puts
      end
    end

    private

    attr_reader :output, :projects

  end
end
