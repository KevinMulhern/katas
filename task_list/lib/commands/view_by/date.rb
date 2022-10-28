module Commands
  module ViewBy
    class Date

      def initialize(output:, projects:)
        @output = output
        @projects = projects
      end

      def self.execute(**args)
        new(output: args.fetch(:output), projects: args.fetch(:projects)).execute
      end

      def execute
        projects.task_creation_dates.each do |date|
          output.puts date.to_s

          projects.tasks_created_on(date).each do |task|
            output.printf("  [%c] %d: %s\n", (task.done? ? 'x' : ' '), task.id, task.description)
          end

          output.puts
        end
      end

      private

      attr_reader :output, :projects

    end
  end
end
