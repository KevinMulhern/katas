require_relative '../../lib/commands/delete'

RSpec.describe Commands::Delete do

  describe '#execute' do
    context 'when the task exists' do
      it 'deletes the task from the project' do
        project = Project.new(
          'test-project',
          [
            Task.new(id: '1', description: 'My First Task', done: false),
            Task.new(id: '2', description: 'My Second Task', done: false),
            Task.new(id: '3', description: 'My Third Task', done: false),
          ]
        )
        project_list = ProjectList.new([project])

        expect(project.tasks.count).to eq(3)
        described_class.execute(output: nil, projects: project_list, params: '2')
        expect(project.tasks.count).to eq(2)
      end
    end

    context 'when the task does not exist' do
      it 'prints an error message' do
        output = StringIO.new
        project_list = ProjectList.new
        command = described_class.new(output: output, projects: project_list, task_id: '2')

        command.execute

        expect(output.string).to eq("Could not find a task with an ID of 2.\n")
      end
    end
  end
end
