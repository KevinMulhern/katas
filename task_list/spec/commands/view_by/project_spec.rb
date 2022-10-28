require_relative '../../../lib/commands/view_by/project'

RSpec.describe Commands::ViewBy::Project do

  describe '#execute' do

    context 'with no projects' do
      it 'prints nothing' do
        output = StringIO.new
        project_list = ProjectList.new([])

        described_class.execute(output: output, projects: project_list, params: {})

        expect(output.string).to eq('')
      end
    end

    context 'with one project' do
      it 'prints the tasks for the project' do
        output = StringIO.new
        project_list = ProjectList.new([Project.new('test-project', [Task.new(1, 'My Task', false)])])

        described_class.execute(output: output, projects: project_list, params: {})

        expect(output.string).to eq(
          <<~VIEW
            test-project
              [ ] 1: My Task

          VIEW
        )
      end
    end

    context 'with multiple projects' do
      it 'prints the tasks for the project' do
        output = StringIO.new
        project_one = Project.new(
          'test-project',
          [
            Task.new(1, 'My First Task', false),
            Task.new(2, 'My Second Task', false),
          ]
        )
        project_two = Project.new('another-project', [Task.new(3, 'My Third Task', false)])
        project_list = ProjectList.new([project_one, project_two])

        described_class.execute(output: output, projects: project_list)

        expect(output.string).to eq(
          <<~VIEW
            test-project
              [ ] 1: My First Task
              [ ] 2: My Second Task

            another-project
              [ ] 3: My Third Task

          VIEW
        )
      end

    end
  end
end
