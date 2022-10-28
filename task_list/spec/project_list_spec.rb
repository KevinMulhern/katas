require_relative '../lib/project_list'

RSpec.describe ProjectList do

  describe '#add' do
    it 'adds a new project to the list' do
      project_list = described_class.new

      project_list.add('test-project')

      expect(project_list.first.name).to eq('test-project')
    end
  end

  describe '#all' do
    it 'returns all projects' do
      project_one = instance_double(Project)
      project_two = instance_double(Project)
      project_list = described_class.new([project_one, project_two])

      expect(project_list.all).to eq([project_one, project_two])
    end
  end

  describe '#find' do
    it 'finds a project by name' do
      project_one = instance_double(Project, name: 'test-project')
      project_two = instance_double(Project, name: 'another-project')
      project_list = described_class.new([project_one, project_two])

      expect(project_list.find('test-project')).to eq(project_one)
    end
  end

  describe '#find_task' do
    it 'finds a task by id' do
      expected_task = instance_double(Task, id: 12)
      unexpected_task = instance_double(Task, id: 89)
      project_one = instance_double(Project, tasks: [expected_task])
      project_two = instance_double(Project, tasks: [unexpected_task])
      project_list = described_class.new([project_one, project_two])

      expect(project_list.find_task(12)).to eq(expected_task)
    end
  end

  describe '#tasks_with_deadline' do
    it 'finds all tasks with a given deadline' do
      expected_task = instance_double(Task, deadline: Date.new(2019, 1, 1))
      unexpected_task = instance_double(Task, deadline: Date.new(2019, 1, 2))
      project_one = instance_double(Project, tasks: [expected_task])
      project_two = instance_double(Project, tasks: [unexpected_task])
      project_list = described_class.new([project_one, project_two])

      expect(project_list.tasks_with_deadline(Date.new(2019, 1, 1))).to eq([expected_task])
    end
  end

  describe '#deadlines' do
    it 'returns all unique deadlines' do
      project_one = instance_double(Project, tasks: [instance_double(Task, deadline: Date.new(2019, 1, 1))])
      project_two = instance_double(Project, tasks: [instance_double(Task, deadline: Date.new(2019, 1, 2))])
      project_three = instance_double(Project, tasks: [instance_double(Task, deadline: Date.new(2019, 1, 2))])
      project_list = described_class.new([project_one, project_two, project_three])

      expect(project_list.deadlines).to eq([Date.new(2019, 1, 1), Date.new(2019, 1, 2)])
    end
  end

  describe '#delete_task' do
    it 'deletes a task from a project' do
      task = instance_double(Task, id: 12)
      project = instance_double(Project, tasks: [task])
      project_list = described_class.new([project])

      project_list.delete_task(task)

      expect(project.tasks).to be_empty
    end
  end
end
