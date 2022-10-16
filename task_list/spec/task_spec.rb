require_relative '../lib/task'

RSpec.describe Task do

  describe '#id' do
    it 'returns the task id' do
      task = Task.new(1, 'My Task', false)

      expect(task.id).to eq(1)
    end
  end

  describe '#description' do
    it 'returns the task description' do
      task = Task.new(1, 'My Task', false)

      expect(task.description).to eq('My Task')
    end
  end

  describe '#mark_done' do
    it 'marks the task as done' do
      task = Task.new(1, 'My Task', false)

      task.mark_done
      expect(task).to be_done
    end
  end

  describe '#mark_undone' do
    it 'marks the task as not done' do
      task = Task.new(1, 'My Task', true)

      task.mark_undone
      expect(task).not_to be_done
    end
  end

  describe '#done?' do
    it 'returns true if the task is done' do
      task = Task.new(1, 'My Task', true)

      expect(task).to be_done
    end

    it 'returns false if the task is not done' do
      task = Task.new(1, 'My Task', false)

      expect(task).not_to be_done
    end
  end
end
