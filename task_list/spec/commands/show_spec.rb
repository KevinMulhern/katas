require_relative '../../lib/commands/show'

RSpec.describe Commands::Show do

  describe '#execute' do

    context 'with one task' do
      it 'prints the tasks for the project' do
        output = StringIO.new
        project_list = ProjectList.new([Project.new('test-project', [Task.new(1, 'My Task', false)])])

        described_class.execute(output: output, projects: project_list, params: {})

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
        project = Project.new(
          'test-project',
          [
            Task.new(1, 'My First Task', false),
            Task.new(2, 'My Second Task', false),
          ]
        )
        project_list = ProjectList.new([project])

        described_class.execute(output: output, projects: project_list)

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
