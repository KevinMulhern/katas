require_relative '../../lib/commands/add_task'
require_relative '../../lib/project_list'
require_relative '../../lib/task'

RSpec.describe Commands::AddTask do

  describe '#execute' do
    it 'adds the task to the project' do
      project = Project.new('test-project')
      project_list = ProjectList.new([project])
      command = described_class.new(
        projects: project_list,
        output: nil,
        project_name: 'test-project',
        name: 'My Task'
      )

      command.execute

      expect(project.tasks.first.description).to eq('My Task')
    end

    it 'assigns the task an ID' do
      project = Project.new('test-project')
      project_list = ProjectList.new([project])
      command = described_class.new(
        projects: project_list,
        output: nil,
        project_name: 'test-project',
        name: 'My Task'
      )

      command.execute

      expect(project.tasks.first.id).to eq(1)
    end

    it 'assigns incremental IDs' do
      project = Project.new('test-project', [Task.new(id: 1, description: 'My Task', done: false)])
      project_list = ProjectList.new([project])
      command = described_class.new(
        projects: project_list,
        output: nil,
        project_name: 'test-project',
        name: 'My Task'
      )

      command.execute

      expect(project.tasks.first.id).to eq(1)
      expect(project.tasks.last.id).to eq(2)
    end

    context 'when the project does not exist' do
      it 'prints an error message' do
        output = StringIO.new
        projects = ProjectList.new([])
        command = described_class.new(
          projects: projects,
          output: output,
          project_name: 'test-project',
          name: 'My Task'
        )

        command.execute

        expect(output.string).to eq("Could not find a project with the name \"test-project\".\n")
      end
    end
  end
end
