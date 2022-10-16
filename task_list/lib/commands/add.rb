module Commands
  class Add

    def initialize(output, tasks)
      @output = output
      @tasks = tasks
    end

    def execute(command_line)
      subcommand, rest = command_line.split(/ /, 2)
      if subcommand == 'project'
        add_project rest
      elsif subcommand == 'task'
        project, description = rest.split(/ /, 2)
        add_task project, description
      end
    end

    private

    def add_project(name)
      @tasks[name] = []
    end

    def add_task(project, description)
      project_tasks = @tasks[project]
      if project_tasks.nil?
        @output.printf("Could not find a project with the name \"%s\".\n", project)
        return
      end
      project_tasks << Task.new(next_id, description, false)
    end

    def next_id
      all_tasks = @tasks.flat_map { |_, project_tasks| project_tasks }
      last_task_id = all_tasks.last&.id

      last_task_id ||= 0
      last_task_id + 1
    end

  end
end
