require_relative '../../lib/commands/deadline'

RSpec.describe Commands::Deadline do

  describe '#execute' do
    context 'when the task exists' do
      it 'adds the deadline to the task' do
        project = Project.new('test-project', [Task.new(id: 1, description: 'My Task', done: false)])
        project_list = ProjectList.new([project])

        described_class.execute(output: nil, projects: project_list, params: '1 2019-01-01')
        expect(project.tasks.first.deadline).to eq(Date.new(2019, 1, 1))
      end
    end

    context 'when the task does not exist' do
      it 'prints an error message' do
        output = StringIO.new
        project_list = ProjectList.new
        command = described_class.new(output: output, projects: project_list, task_id: '1', deadline: '2019-01-01')

        command.execute

        expect(output.string).to eq("Could not find a task with an ID of 1.\n")
      end
    end
  end
end
