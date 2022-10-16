module Commands
  class Add

    def initialize(output, projects)
      @output = output
      @projects = projects
    end

    def execute(command_line)
      subcommand, rest = command_line.split(/ /, 2)

      if subcommand == 'project'
        add_project(rest)
      elsif subcommand == 'task'
        project, description = rest.split(/ /, 2)
        add_task(project, description)
      end
    end

    private

    attr_reader :output, :projects

    def add_project(name)
      projects[name] = []
    end

    def add_task(project, description)
      project_tasks = projects[project]

      if project_tasks.nil?
        output.printf("Could not find a project with the name \"%s\".\n", project)
        return
      end

      project_tasks << Task.new(next_id, description, false)
    end

    def next_id
      all_tasks = projects.flat_map { |_, tasks| tasks }
      last_task_id = all_tasks.last&.id

      last_task_id ||= 0
      last_task_id + 1
    end
  end
end
