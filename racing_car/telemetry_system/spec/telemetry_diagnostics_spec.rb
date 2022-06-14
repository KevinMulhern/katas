require_relative '../telemetry'

describe TelemetryDiagnostics do
  describe "#diagnostic_info" do
    let(:telemetry_client) { instance_double(TelemetryClientAdapter) }

    context "when the client is online" do

      before do
        allow(TelemetryClientAdapter).to receive(:new).and_return(telemetry_client)
        allow(telemetry_client).to receive(:diagnostic_info_for).and_return("foo")
      end

      it "returns the correct diagnostic info" do
        telemetry_diagnostics = TelemetryDiagnostics.new

        telemetry_diagnostics.check_transmission

        expect(telemetry_diagnostics.diagnostic_info).to eq("foo")
      end
    end

    context "when the client is offline" do

      before do
        allow(TelemetryClientAdapter).to receive(:new).and_return(telemetry_client)
        allow(telemetry_client).to receive(:diagnostic_info_for).and_raise(Exception.new("Unable to connect."))
      end

      it "raises an unable to connect error" do
        telemetry_diagnostics = TelemetryDiagnostics.new

        expect { telemetry_diagnostics.check_transmission }.to raise_error(Exception, "Unable to connect.")
      end
    end
  end
end
