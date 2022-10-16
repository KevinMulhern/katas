module Commands
  class Check

    def initialize(output, tasks)
      @output = output
      @tasks = tasks
    end

    def execute(id_string)
      set_done(id_string, true)
    end

    private

    def set_done(id_string, done)
      id = id_string.to_i
      task = @tasks.collect { |project_name, project_tasks|
        project_tasks.find { |t| t.id == id }
      }.reject(&:nil?).first

      if task.nil?
        @output.printf("Could not find a task with an ID of %d.\n", id)
        return
      end

      task.done = done
    end


  end
end
