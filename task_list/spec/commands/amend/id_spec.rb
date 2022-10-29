require_relative '../../../lib/commands/amend/id'
require_relative '../../../lib/project_list'
require_relative '../../../lib/task'

RSpec.describe Commands::Amend::Id do

  describe '#execute' do
    it 'changes the id' do
      task = Task.new(id: '1', description: 'My Task', done: false)
      project = Project.new('test-project', [task])
      project_list = ProjectList.new([project])

      command = described_class.new(
        projects: project_list,
        output: nil,
        old_id: '1',
        new_id: 'A1'
      )

      command.execute

      expect(task.id).to eq('A1')
    end

    context 'when the task does not exist' do
      it 'prints an error message' do
        output = StringIO.new
        project_list = ProjectList.new
        command = described_class.new(
          projects: project_list,
          output: output,
          old_id: '1',
          new_id: 'A1'
        )

        command.execute

        expect(output.string).to eq("Could not find a task with an ID of 1.\n")
      end
    end

    context 'when the new id is already taken' do
      it 'prints an error message' do
        output = StringIO.new
        project = Project.new(
          'test-project',
          [
            Task.new(id: '1', description: 'My Task', done: false),
            Task.new(id: 'A1', description: 'My Task', done: false)
          ]
        )
        project_list = ProjectList.new([project])
        command = described_class.new(
          projects: project_list,
          output: output,
          old_id: '1',
          new_id: 'A1'
        )

        command.execute

        expect(output.string).to eq("A task with an ID of A1 already exists.\n")
      end
    end
  end
end
