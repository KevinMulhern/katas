require_relative '../trip/trip_service'
require_relative '../trip/trip_dao'
require_relative '../trip/trip'
require_relative '../user/user_session'
require_relative '../user/user'

RSpec.describe TripService do
  subject(:trip_service) { TripService.new }

  describe '#get_trip_by_user' do

    context 'when logged in' do
      it 'returns friends trips' do
        friend = User.new
        current_user = User.new
        trip = Trip.new
        friend.add_friend(current_user)
        friend.add_trip(trip)

        expect(trip_service.get_trip_by_user(friend, current_user)).to eq([trip])
      end
    end

    context 'when logged in but not a friend' do
      it 'returns no trips' do
        current_user = User.new
        friend = User.new

        expect(trip_service.get_trip_by_user(friend, current_user)).to eq([])
      end
    end

    context 'when not logged in' do
      it 'raises a not logged in exception' do
        friend = User.new

        expect { trip_service.get_trip_by_user(friend, nil) }.to raise_error(UserNotLoggedInException)
      end
    end
  end

end
