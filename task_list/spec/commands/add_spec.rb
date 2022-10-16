require_relative '../../lib/commands/add'

RSpec.describe Commands::Add do

  describe '#execute' do
    context 'when adding a project' do
      it 'adds the project to the tasks' do
        tasks = {}
        add = Commands::Add.new(nil, tasks)

        add.execute('project test-project')

        expect(tasks).to eq('test-project' => [])
      end
    end

    context 'when adding a task' do
      it 'adds the task to the project' do
        tasks = { 'test-project' => [] }
        add = Commands::Add.new(nil, tasks)

        add.execute('task test-project My Task')

        expect(tasks["test-project"].first.description).to eq('My Task')
      end

      it 'assigns the task an ID' do
        tasks = { 'test-project' => [] }
        add = Commands::Add.new(nil, tasks)

        add.execute('task test-project My Task')

        expect(tasks["test-project"].first.id).to eq(1)
      end

      it 'assigns incremental IDs' do
        tasks = { 'test-project' => [] }
        add = Commands::Add.new(nil, tasks)

        add.execute('task test-project My Task')
        add.execute('task test-project My Task')

        expect(tasks["test-project"].first.id).to eq(1)
        expect(tasks["test-project"].last.id).to eq(2)
      end
    end

    context 'when the project does not exist' do
      it 'prints an error message' do
        output = StringIO.new
        tasks = {}
        add = Commands::Add.new(output, tasks)

        add.execute('task test-project My Task')

        expect(output.string).to eq("Could not find a project with the name \"test-project\".\n")
      end
    end
  end
end
