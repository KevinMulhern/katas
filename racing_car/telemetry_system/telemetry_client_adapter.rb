require './client'

class TelemetryClientAdapter

  def initialize(connection_string)
    @connection_string = connection_string
    @client = client
    @connected = false
  end

  def diagnostic_info_for(diagnostic_message)
    if connected?
      client.send(TelemetryClient::DIAGNOSTIC_MESSAGE)
      client.receive
    else
      raise Exception.new("Unable to connect.")
    end
  end

  def connected?
    @connected
  end

  private

  attr_reader :connection_string

  def client
    return @client if connected?

    telemetry_client = TelemetryClient.new

    retry_left = 3
    while !telemetry_client.online_status && retry_left > 0
      @connected = telemetry_client.connect(connection_string)
      retry_left -= 1
    end

    telemetry_client
  end

end
