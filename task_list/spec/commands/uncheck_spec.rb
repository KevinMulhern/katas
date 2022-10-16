require_relative '../../lib/commands/uncheck'

RSpec.describe Commands::Uncheck do

  describe '#execute' do
    context 'when the task exists' do
      it 'marks the task as not done' do
        projects = { 'test-project' => [Task.new(1, 'My Task', true)] }
        command = described_class.new(output: nil, projects: projects, task_id: '1')

        expect(projects['test-project'].first).to be_done
        command.execute
        expect(projects['test-project'].first).not_to be_done
      end
    end

    context 'when the task does not exist' do
      it 'prints an error message' do
        output = StringIO.new
        projects = {}
        command = described_class.new(output: output, projects: projects, task_id: '1')

        command.execute
        expect(output.string).to eq("Could not find a task with an ID of 1.\n")
      end
    end
  end
end
