require_relative '../../lib/commands/add_project'

RSpec.describe Commands::AddProject do

  describe '#execute' do
    it 'adds a project' do
      projects = { 'a-project' => [] }
      name = 'test-project'
      command = described_class.new(projects: projects, name: name)

      command.execute

      expect(projects).to include('test-project' => [])
    end
  end
end
