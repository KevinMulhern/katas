module Commands
  class Uncheck

    def initialize(output:, projects:, task_id:)
      @output = output
      @projects = projects
      @task_id = task_id.to_i
    end

    def self.execute(**args)
      new(args).execute
    end

    def execute
      task = projects.find_task(task_id)

      if task.nil?
        output.printf("Could not find a task with an ID of %d.\n", task_id)
        return
      end

      task.mark_undone
    end

    private

    attr_reader :output, :projects, :task_id
  end
end
