require_relative '../lib/project'

RSpec.describe Project do

  describe '#name' do
    it 'returns the project name' do
      project = Project.new('my-project')

      expect(project.name).to eq('my-project')
    end
  end

  describe '#tasks' do
    it 'returns the projects tasks' do
      task = instance_double(Task)
      project = Project.new('my-project', [task])

      expect(project.tasks).to eq([task])
    end
  end
end
