require_relative '../../lib/commands/uncheck'

RSpec.describe Commands::Uncheck do

  describe '#execute' do
    context 'when the task exists' do
      it 'marks the task as not done' do
        projects = { 'test-project' => [Task.new(1, 'My Task', true)] }
        check = Commands::Uncheck.new(nil, projects)

        expect(projects['test-project'].first).to be_done
        check.execute('1')
        expect(projects['test-project'].first).not_to be_done
      end
    end

    context 'when the task does not exist' do
      it 'prints an error message' do
        output = StringIO.new
        projects = {}
        check = Commands::Uncheck.new(output, projects)

        check.execute('1')
        expect(output.string).to eq("Could not find a task with an ID of 1.\n")
      end
    end
  end
end
