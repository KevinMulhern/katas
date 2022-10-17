require_relative '../../lib/commands/add'

RSpec.describe Commands::Add do

  describe '#execute' do
    context 'when adding a project' do

      before do
        allow(Commands::AddProject).to receive(:execute)
      end

      it 'delegates to the add project command' do
        projects = instance_double(ProjectList)
        command = described_class.new(
          projects: projects,
          output: nil,
          params: 'project test-project'
        )

        command.execute

        expect(Commands::AddProject).to have_received(:execute).with(
          projects: projects,
          name: 'test-project'
        )
      end
    end

    context 'when adding a task' do
      before do
        allow(Commands::AddTask).to receive(:execute)
      end

      it 'delegates to the add task command' do
        projects = instance_double(ProjectList)
        output = double
        command = described_class.new(
          projects: projects,
          output: output,
          params: 'task test-project My Task'
        )

        command.execute

        expect(Commands::AddTask).to have_received(:execute).with(
          projects: projects,
          output: output,
          project: 'test-project',
          name: 'My Task'
        )
      end
    end
  end
end
