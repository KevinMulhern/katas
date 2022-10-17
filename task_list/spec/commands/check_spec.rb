require_relative '../../lib/commands/check'

RSpec.describe Commands::Check do

  describe '#execute' do
    context 'when the task exists' do
      it 'marks the task as done' do
        project = Project.new('test-project', [Task.new(1, 'My Task', false)])
        project_list = ProjectList.new([project])
        command = described_class.new(output: nil, projects: project_list, task_id: '1')

        expect(project.tasks.first).not_to be_done
        command.execute
        expect(project.tasks.first).to be_done
      end
    end

    context 'when the task does not exist' do
      it 'prints an error message' do
        output = StringIO.new
        project_list = ProjectList.new
        command = described_class.new(output: output, projects: project_list, task_id: '1')

        command.execute
        expect(output.string).to eq("Could not find a task with an ID of 1.\n")
      end
    end
  end
end
