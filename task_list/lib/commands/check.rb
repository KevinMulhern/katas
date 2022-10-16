module Commands
  class Check

    def initialize(output, projects)
      @output = output
      @projects = projects
    end

    def execute(id_string)
      id = id_string.to_i

      task = @projects.collect { |_, tasks|
        tasks.find { |t| t.id == id }
      }.reject(&:nil?).first

      if task.nil?
        output.printf("Could not find a task with an ID of %d.\n", id)
        return
      end

      task.mark_done
    end

    private

    attr_reader :output, :projects
  end
end
