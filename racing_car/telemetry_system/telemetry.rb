require './telemetry_client_adapter'

class TelemetryDiagnostics
  DIAGNOSTIC_CHANNEL_CONNECTION_STRING = "*111#"

  attr_reader :diagnostic_info

  def initialize
    @telemetry_client = TelemetryClientAdapter.new(DIAGNOSTIC_CHANNEL_CONNECTION_STRING)
    @diagnostic_info = ""
  end

  def check_transmission
    @diagnostic_info = @telemetry_client.diagnostic_info_for(
      TelemetryClient::DIAGNOSTIC_MESSAGE
    )
  end
end
