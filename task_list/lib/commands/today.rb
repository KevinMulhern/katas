require 'date'

module Commands
  class Today
    def initialize(output:, projects:, deadline:)
      @output = output
      @projects = projects
      @deadline = deadline
    end

    def self.execute(**args)
      new(
        output: args.fetch(:output),
        projects: args.fetch(:projects),
        deadline: args.fetch(:deadline, Date.today)
      ).execute
    end

    def execute
      tasks = @projects.tasks_with_dealine(deadline)

      if tasks.empty?
        output.puts "No tasks due today."
      else
        tasks.each do |task|
          output.printf("[%c] %d: %s\n", (task.done? ? 'x' : ' '), task.id, task.description)
        end
      end

      output.puts
    end

    private

    attr_reader :output, :projects, :deadline

  end
end
