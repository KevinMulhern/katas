require_relative '../lib/task'

RSpec.describe Task do

  describe '#id' do
    it 'returns the task id' do
      task = Task.new(id: 1, description: 'My Task', done: false)

      expect(task.id).to eq('1')
    end
  end

  describe '#description' do
    it 'returns the task description' do
      task = Task.new(id: 1, description: 'My Task', done: false)

      expect(task.description).to eq('My Task')
    end
  end

  describe '#mark_done' do
    it 'marks the task as done' do
      task = Task.new(id: 1, description: 'My Task', done: false)

      task.mark_done
      expect(task).to be_done
    end
  end

  describe '#mark_undone' do
    it 'marks the task as not done' do
      task = Task.new(id: '1', description: 'My Task', done: true)

      task.mark_undone
      expect(task).not_to be_done
    end
  end

  describe '#done?' do
    it 'returns true if the task is done' do
      task = Task.new(id: '1', description: 'My Task', done: true)

      expect(task).to be_done
    end

    it 'returns false if the task is not done' do
      task = Task.new(id: '1', description: 'My Task', done: false)

      expect(task).not_to be_done
    end
  end

  describe '#add_deadlin' do
    it 'adds a deadline to the task' do
      task = Task.new(id: '1', description: 'My Task', done: true)

      expect(task.deadline).to be_nil
      task.add_deadline(Date.new(2019, 1, 1))
      expect(task.deadline).to eq(Date.new(2019, 1, 1))
    end
  end

  describe '#set_id' do
    it 'sets the task id' do
      task = Task.new(id: '1', description: 'My Task', done: true)

      expect(task.id).to eq('1')
      task.set_id('A1')
      expect(task.id).to eq('A1')
    end
  end
end
