require_relative '../../../lib/commands/view_by/deadline'

RSpec.describe Commands::ViewBy::Deadline do

  describe '#execute' do

    context 'with no deadlines' do
      it 'prints nothing' do
        output = StringIO.new
        project_list = ProjectList.new([Project.new('test-project', [Task.new(1, 'My Task', false)])])

        described_class.execute(output: output, projects: project_list, params: {})

        expect(output.string).to eq('')
      end
    end

    context 'with one deadline' do
      it 'prints the tasks for the deadline' do
        output = StringIO.new
        project_list = ProjectList.new([Project.new('test-project', [Task.new(1, 'My Task', false, '2019-01-01')])])

        described_class.execute(output: output, projects: project_list, params: {})

        expect(output.string).to eq(
          <<~VIEW
            2019-01-01
              [ ] 1: My Task

          VIEW
        )
      end
    end

    context 'with multiple deadlines' do
      it 'prints the tasks for the deadlines' do
        output = StringIO.new
        project_one = Project.new(
          'test-project',
          [
            Task.new(1, 'My First Task', false, '2019-01-01'),
            Task.new(2, 'My Second Task', false, '2019-01-02'),

          ]
        )
        project_two = Project.new('another-project', [Task.new(3, 'My Third Task', false, '2019-01-01')])
        project_list = ProjectList.new([project_one, project_two])

        described_class.execute(output: output, projects: project_list)

        expect(output.string).to eq(
          <<~VIEW
            2019-01-01
              [ ] 1: My First Task
              [ ] 3: My Third Task

            2019-01-02
              [ ] 2: My Second Task

          VIEW
        )
      end

    end
  end
end
