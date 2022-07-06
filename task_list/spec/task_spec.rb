require_relative '../lib/task'

RSpec.describe Task do

  describe '#done?' do
    context 'when the task is done' do
      it 'returns true' do
        task = Task.new(1, 'Buy the milk', true)

        expect(task.done?).to eq(true)
      end
    end

    context 'when the task is not done' do
      it 'returns false' do
        task = Task.new(1, 'Buy the milk', false)

        expect(task.done?).to eq(false)
      end
    end
  end

  describe "#set_deadline" do
    it "sets the tasks deadline" do
      task = Task.new(1, 'Buy the milk', false)

      expect(task.set_deadline('11/12/1990')).to eq(Date.parse('11/12/1990'))
    end
  end
end
