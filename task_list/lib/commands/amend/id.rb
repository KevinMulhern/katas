module Commands
  class Amend
    class Id

      def initialize(output:, projects:, old_id:, new_id:)
        @output = output
        @projects = projects
        @old_id = old_id
        @new_id = new_id
      end

      def self.execute(**args)
        new(args).execute
      end

      def execute
        return invalid_id_error unless new_id_valid?

        task = projects.find_task(old_id)

        if task.nil?
          output.printf("Could not find a task with an ID of %s.\n", old_id)
          return
        end

        if projects.task_has_id?(new_id)
          output.printf("A task with an ID of %s already exists.\n", new_id)
          return
        end

        task.set_id(new_id)
      end

      private

      attr_reader :output, :projects, :old_id, :new_id

      def new_id_valid?
        new_id.match?(/\A[a-z0-9A-Z ]+\z/)
      end

      def invalid_id_error
        output.printf("%s is invalid and invalid ID, must only contain letters and numbers.\n", new_id)
      end
    end
  end
end
