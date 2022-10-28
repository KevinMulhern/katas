require_relative '../../lib/commands/view'

RSpec.describe Commands::View do

  describe '#execute' do
    context 'when viewing by project' do

      before do
        allow(Commands::ViewBy::Project).to receive(:execute)
      end

      it 'delegates to the view by project command' do
        projects = instance_double(ProjectList)
        output = double
        command = described_class.new(
          projects: projects,
          output: output,
          params: 'by project'
        )

        command.execute

        expect(Commands::ViewBy::Project).to have_received(:execute).with(
          projects: projects,
          output: output
        )
      end
    end

    context 'when viewing by deadline' do

      before do
        allow(Commands::ViewBy::Deadline).to receive(:execute)
      end

      it 'delegates to the view by deadline command' do
        projects = instance_double(ProjectList)
        output = double
        command = described_class.new(
          projects: projects,
          output: output,
          params: 'by deadline'
        )

        command.execute

        expect(Commands::ViewBy::Deadline).to have_received(:execute).with(
          projects: projects,
          output: output
        )
      end
    end
  end
end
