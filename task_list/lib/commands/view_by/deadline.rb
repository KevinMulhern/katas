module Commands
  module ViewBy
    class Deadline

      def initialize(output:, projects:)
        @output = output
        @projects = projects
      end

      def self.execute(**args)
        new(output: args.fetch(:output), projects: args.fetch(:projects)).execute
      end

      def execute
        projects.deadlines.each do |deadline|
          output.puts deadline.to_s

          projects.tasks_with_deadline(deadline).each do |task|
            output.printf("  [%c] %s: %s\n", (task.done? ? 'x' : ' '), task.id, task.description)
          end

          output.puts
        end
      end

      private

      attr_reader :output, :projects

    end
  end
end
