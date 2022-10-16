module Commands
  class Show
    def initialize(output, tasks)
      @output = output
      @tasks = tasks
    end

    def execute
      @tasks.each do |project_name, project_tasks|
        @output.puts project_name
        project_tasks.each do |task|
          @output.printf("  [%c] %d: %s\n", (task.done? ? 'x' : ' '), task.id, task.description)
        end
        @output.puts
      end
    end

  end
end
