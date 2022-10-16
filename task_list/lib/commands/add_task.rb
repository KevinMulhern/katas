module Commands
  class AddTask

    def initialize(projects:, output:, project:, name:)
      @projects = projects
      @output = output
      @project = project
      @name = name
    end

    def self.execute(**args)
      new(args).execute
    end

    def execute
      project_tasks = projects[project]

      if project_tasks.nil?
        output.printf("Could not find a project with the name \"%s\".\n", project)
        return
      end

      project_tasks << Task.new(next_id, name, false)
    end

    def next_id
      all_tasks = projects.flat_map { |_, tasks| tasks }
      last_task_id = all_tasks.last&.id

      last_task_id ||= 0
      last_task_id + 1
    end

    private

    attr_reader :projects, :output, :project, :name
  end
end
