require_relative '../../../lib/commands/view_by/project'
require_relative '../../../lib/project_list'
require_relative '../../../lib/project'
require_relative '../../../lib/task'

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
        project_list = ProjectList.new([
          Project.new(
            'test-project',
            [
              Task.new(id: 1, description: 'My Task', done: false)
            ]
          )
        ])

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
            Task.new(id: 1, description: 'My First Task', done: false),
            Task.new(id: 2, description: 'My Second Task', done: false),
          ]
        )
        project_two = Project.new(
          'another-project',
          [
            Task.new(id: 3, description: 'My Third Task', done: false)
          ]
        )
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
