require_relative 'task'
require_relative 'project_list'

# TODO: Glob these files
require_relative 'commands/show'
require_relative 'commands/add'
require_relative 'commands/check'
require_relative 'commands/uncheck'
require_relative 'commands/help'
require_relative 'commands/deadline'
require_relative 'commands/today'

class TaskList
  QUIT = 'quit'

  def initialize(input, output)
    @input = input
    @output = output

    @projects = ProjectList.new
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

    begin
      command_obj = Commands.const_get(command.capitalize)
    rescue NameError
      @output.printf("I don't know what the command \"%s\" is.\n", command)
    else
      command_obj.public_send(:execute, output: @output, projects: @projects, params: rest)
    end
  end
end

if __FILE__ == $0
  TaskList.new($stdin, $stdout).run
end
