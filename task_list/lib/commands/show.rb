module Commands
  class Show
    def initialize(output, projects)
      @output = output
      @projects = projects
    end

    def execute
      projects.each do |name, tasks|
        output.puts name

        tasks.each do |task|
          output.printf("  [%c] %d: %s\n", (task.done? ? 'x' : ' '), task.id, task.description)
        end

        output.puts
      end
    end

    private

    attr_reader :output, :projects

  end
end
