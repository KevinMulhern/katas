require_relative '../../lib/commands/show'

RSpec.describe Commands::Show do

  describe '#execute' do

    context 'with one task' do
      it 'prints the tasks for the project' do
        output = StringIO.new
        projects = { 'test-project' => [Task.new(1, 'My Task', false)] }
        show = Commands::Show.new(output, projects)

        show.execute

        expect(output.string).to eq(
          <<~SHOW
            test-project
              [ ] 1: My Task

          SHOW
        )
      end
    end

    context 'with multiple tasks' do
      it 'prints the tasks for the project' do
        output = StringIO.new
        projects = {
          'test-project' => [
            Task.new(1, 'My First Task', false),
            Task.new(2, 'My Second Task', false),
          ]
        }
        show = Commands::Show.new(output, projects)

        show.execute

        expect(output.string).to eq(
          <<~SHOW
            test-project
              [ ] 1: My First Task
              [ ] 2: My Second Task

          SHOW
        )
      end

    end
  end
end
