require_relative 'task'

# TODO: Glob these files
require_relative 'commands/show'
require_relative 'commands/add'
require_relative 'commands/check'
require_relative 'commands/uncheck'
require_relative 'commands/help'

class TaskList
  QUIT = 'quit'

  def initialize(input, output)
    @input = input
    @output = output

    @projects = {}
  end

  def run
    while true
      @output.print('> ')
      @output.flush

      command = @input.readline.strip
      break if command == QUIT

      execute(command)
    end
  end

  private

  def execute(command_line)
    command, rest = command_line.split(/ /, 2)

    case command
      when 'show'
        Commands::Show.execute(output: @output, projects: @projects)
      when 'add'
        Commands::Add.execute(output: @output, projects: @projects, params: rest)
      when 'check'
        Commands::Check.execute(output: @output, projects: @projects, task_id: rest)
      when 'uncheck'
        Commands::Uncheck.execute(output: @output, projects: @projects, task_id: rest)
      when 'help'
        Commands::Help.execute(outputs: @output)
      else
        @output.printf("I don't know what the command \"%s\" is.\n", command)
    end
  end
end

if __FILE__ == $0
  TaskList.new($stdin, $stdout).run
end
