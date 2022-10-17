module Commands
  class AddTask

    def initialize(projects:, output:, project_name:, name:)
      @projects = projects
      @output = output
      @project_name = project_name
      @name = name
    end

    def self.execute(**args)
      new(args).execute
    end

    def execute
      project = projects.find(project_name)

      if project.nil?
        output.printf("Could not find a project with the name \"%s\".\n", project_name)
        return
      end

      project.tasks << Task.new(next_id, name, false)
    end

    def next_id
      all_tasks = projects.all.flat_map(&:tasks)
      last_task_id = all_tasks.last&.id

      last_task_id ||= 0
      last_task_id + 1
    end

    private

    attr_reader :projects, :output, :project_name, :name
  end
end
