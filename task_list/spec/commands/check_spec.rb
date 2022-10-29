require_relative '../../lib/commands/check'

RSpec.describe Commands::Check do

  describe '#execute' do
    context 'when the task exists' do
      it 'marks the task as done' do
        project = Project.new('test-project', [Task.new(id: '1', description: 'My Task', done: false)])
        project_list = ProjectList.new([project])

        expect(project.tasks.first).not_to be_done
        described_class.execute(output: nil, projects: project_list, params: '1')
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
