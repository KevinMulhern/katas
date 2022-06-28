require_relative '../trip/trip_dao'
require_relative '../user/user_session'
require_relative '../user/user'
require_relative '../еxceptions/user_not_logged_in_exception'
require_relative '../еxceptions/dependend_class_call_during_unit_test_exception'

class TripService
  NO_TRIPS = []

  def get_trip_by_user(user)
    raise UserNotLoggedInException.new if logged_in_user.nil?

    if user.has_friend?(logged_in_user)
      get_trips_for(user)
    else
      NO_TRIPS
    end
  end

  private

  def logged_in_user
    UserSession.get_instance.get_logged_user
  end

  def get_trips_for(user)
    TripDAO.find_trips_by_user(user)
  end

end
