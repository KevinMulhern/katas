class AuthenticationService

  #
  # the goal is to replace the following method with:
  # def authenticated?(role, user_id)
  #

  def authenticated?(user_id)
    user_id == 12345
  end
end

class AuthenticationClient
  def initialize(authentication_service)
    @authentication_service = authentication_service
  end

  def run
    authenticated = @authentication_service.authenticated?(33)
    puts "authenticated: #{authenticated}"
  end
end

class YetAnotherClient
  def run
    AuthenticationService.new.authenticated?(100)
  end
end

if __FILE__ == $PROGRAM_NAME
  client = AuthenticationClient.new(AuthenticationService.new)
  client.run
end
