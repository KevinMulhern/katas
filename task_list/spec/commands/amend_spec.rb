require_relative '../../lib/commands/amend'

RSpec.describe Commands::Amend do

  describe '#execute' do
    context 'when amending an id' do

      before do
        allow(Commands::Amend::Id).to receive(:execute)
      end

      it 'delegates to the amend id command' do
        projects = instance_double(ProjectList)
        output = StringIO.new
        command = described_class.new(
          projects: projects,
          output: output,
          params: 'id 1 A1'
        )

        command.execute

        expect(Commands::Amend::Id).to have_received(:execute).with(
          projects: projects,
          output: output,
          old_id: '1',
          new_id: 'A1'
        )
      end
    end
  end
end
