require_relative '../../lib/commands/today'
require_relative '../../lib/project_list'
require_relative '../../lib/project'
require_relative '../../lib/task'

RSpec.describe Commands::Today do

  describe '#execute' do

    context 'when tasks match the deadline' do
      it 'prints the tasks' do
        output = StringIO.new
        project = Project.new(
          'test-project',
          [
            Task.new(id: 1, description: 'My First Task', done: false, deadline: Date.today),
            Task.new(id: 2, description: 'My Second Task', done: false, deadline: Date.today + 1),
            Task.new(id: 3, description: 'My Third Task', done: false, deadline: Date.today),
          ]
        )
        project_list = ProjectList.new([project])

        described_class.execute(output: output, projects: project_list, params: {})

        expect(output.string).to eq(
          <<~Today
            [ ] 1: My First Task
            [ ] 3: My Third Task

          Today
        )
      end
    end

    context 'when no tasks match the dealine' do
      it 'prints no tasks' do
        output = StringIO.new
        project = Project.new(
          'test-project',
          [
            Task.new(id: 1, description: 'My First Task', done: false),
            Task.new(id: 2, description: 'My Second Task', done: false),
          ]
        )
        project_list = ProjectList.new([project])

        described_class.execute(output: output, projects: project_list)

        expect(output.string).to eq(
          <<~Today
            No tasks due today.

          Today
        )
      end

    end
  end
end
