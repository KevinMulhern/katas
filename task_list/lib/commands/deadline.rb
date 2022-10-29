require 'date'

module Commands
  class Deadline

    def initialize(output:, projects:, task_id:, deadline:)
      @output = output
      @projects = projects
      @task_id = task_id
      @deadline = deadline
    end

    def self.execute(**args)
      params = Params.new(args.fetch(:params))

      new(
        output: args.fetch(:output),
        projects: args.fetch(:projects),
        task_id: params.task_id,
        deadline: params.deadline
      ).execute
    end

    def execute
      task = @projects.find_task(task_id)

      if task.nil?
        output.printf("Could not find a task with an ID of %d.\n", task_id)
        return
      end

      task.add_deadline(deadline)
    end

    private

    attr_reader :output, :projects, :task_id, :deadline

    class Params
      def initialize(params)
        @params = params.split(' ', 3)
      end

      def deadline
        Date.parse(@params.last)
      end

      def task_id
        @params.first
      end
    end
  end
end
