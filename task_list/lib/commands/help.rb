module Commands
  class Help

    def initialize(output:)
      @output = output
    end

    def self.execute(**args)
      new(output: args[:output]).execute
    end

    def execute
      output.puts('Commands:')
      output.puts('  show')
      output.puts('  add project <project name>')
      output.puts('  add task <project name> <task description>')
      output.puts('  check <task ID>')
      output.puts('  uncheck <task ID>')
      output.puts()
    end

    private

    attr_reader :output
  end
end
