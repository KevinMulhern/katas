require_relative '../../lib/commands/add_task'

RSpec.describe Commands::AddTask do

  describe '#execute' do
    it 'adds the task to the project' do
      projects = ProjectList.new({ 'test-project' => [] })
      command = described_class.new(projects: projects, output: nil, project: 'test-project', name: 'My Task')

      command.execute

      expect(projects["test-project"].first.description).to eq('My Task')
    end

    it 'assigns the task an ID' do
      projects = ProjectList.new({ 'test-project' => [] })
      command = described_class.new(projects: projects, output: nil, project: 'test-project', name: 'My Task')

      command.execute

      expect(projects["test-project"].first.id).to eq(1)
    end

    it 'assigns incremental IDs' do
      projects = ProjectList.new({ 'test-project' => [Task.new(1, 'My Task', false)] })
      command = described_class.new(projects: projects, output: nil, project: 'test-project', name: 'My Task')

      command.execute

      expect(projects["test-project"].first.id).to eq(1)
      expect(projects["test-project"].last.id).to eq(2)
    end

    context 'when the project does not exist' do
      it 'prints an error message' do
        output = StringIO.new
        projects = ProjectList.new({})
        command = described_class.new(projects: projects, output: output, project: 'test-project', name: 'My Task')

        command.execute

        expect(output.string).to eq("Could not find a project with the name \"test-project\".\n")
      end
    end
  end
end
