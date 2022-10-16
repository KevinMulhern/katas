require_relative '../../lib/commands/help'

RSpec.describe Commands::Help do

  describe '#execute' do
    it 'prints the help documentation' do
      output = StringIO.new
      help = Commands::Help.new(output)
      help.execute

      expect(output.string).to eq(
        <<~HELP
          Commands:
            show
            add project <project name>
            add task <project name> <task description>
            check <task ID>
            uncheck <task ID>

        HELP
      )
    end
  end
end
