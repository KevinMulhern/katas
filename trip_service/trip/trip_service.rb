require_relative '../trip/trip_dao'
require_relative '../user/user_session'
require_relative '../user/user'
require_relative '../еxceptions/user_not_logged_in_exception'
require_relative '../еxceptions/dependend_class_call_during_unit_test_exception'

class TripService
  NO_TRIPS = []

  def get_trip_by_user(friend, current_user)
    raise UserNotLoggedInException.new if current_user.nil?

    if friend.has_friend?(current_user)
      friend.trips
    else
      NO_TRIPS
    end
  end

end
