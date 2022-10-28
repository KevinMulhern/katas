require_relative '../../lib/commands/uncheck'

RSpec.describe Commands::Uncheck do

  describe '#execute' do
    context 'when the task exists' do
      it 'marks the task as not done' do
        project = Project.new('test-project', [Task.new(id: 1, description: 'My Task', done: true)])
        project_list = ProjectList.new([project])

        expect(project.tasks.first).to be_done
        described_class.execute(output: nil, projects: project_list, params: '1')
        expect(project.tasks.first).not_to be_done
      end
    end

    context 'when the task does not exist' do
      it 'prints an error message' do
        output = StringIO.new
        project_list = ProjectList.new

        described_class.execute(output: output, projects: project_list, params: '1')

        expect(output.string).to eq("Could not find a task with an ID of 1.\n")
      end
    end
  end
end
