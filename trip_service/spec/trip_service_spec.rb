require_relative '../trip/trip_service'
require_relative '../trip/trip_dao'
require_relative '../trip/trip'
require_relative '../user/user_session'
require_relative '../user/user'

RSpec.describe TripService do
  subject(:trip_service) { TripService.new }

  describe '#get_trip_by_user' do

    context 'when other user is logged in' do

      it 'returns the users trips' do
        user = User.new
        other_user = User.new
        trip = Trip.new

        user.add_friend(other_user)
        allow(TripDAO).to receive(:find_trips_by_user).with(user).and_return([trip])

        expect(trip_service.get_trip_by_user(user, other_user)).to eq([trip])
      end
    end

    context 'when other user is logged in but is not a friend' do
      it 'returns no trips' do
        user = User.new
        other_user = User.new

        expect(trip_service.get_trip_by_user(user, other_user)).to eq([])
      end
    end

    context 'when other user is not logged in' do
      it 'raises a not logged in exception' do
        user = User.new

        expect { trip_service.get_trip_by_user(user, nil) }.to raise_error(UserNotLoggedInException)
      end
    end
  end

end
