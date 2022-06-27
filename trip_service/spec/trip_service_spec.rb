require_relative '../trip/trip_service'
require_relative '../trip/trip_dao'
require_relative '../trip/trip'
require_relative '../user/user_session'
require_relative '../user/user'

RSpec.describe TripService do
  subject(:trip_service) { TripService.new }

  describe '#get_trip_by_user' do

    before do
      allow(UserSession).to receive(:get_instance).and_return(user_session)
    end

    context 'when a user is logged in' do

      let(:user_session) { instance_double(UserSession, get_logged_user: logged_user) }
      let(:logged_user) { instance_double(User) }

      it 'returns the users trips' do
        user = instance_double(User)
        trip = instance_double(Trip)
        allow(user).to receive(:get_friends).and_return([logged_user])
        allow(TripDAO).to receive(:find_trips_by_user).with(user).and_return([trip])

        expect(trip_service.get_trip_by_user(user)).to eq([trip])
      end
    end

    context 'when a user is logged in but is not a friend' do
      let(:user_session) { instance_double(UserSession, get_logged_user: logged_user) }
      let(:logged_user) { instance_double(User) }

      it 'returns no trips' do
        user = instance_double(User)
        allow(user).to receive(:get_friends).and_return([])

        expect(trip_service.get_trip_by_user(user)).to eq([])
      end
    end

    context 'when no users logged in' do
      let(:user_session) { instance_double(UserSession, get_logged_user: nil) }

      it 'raises a not logged in exception' do
        user = instance_double(User)

        expect { trip_service.get_trip_by_user(user) }.to raise_error(UserNotLoggedInException)
      end
    end
  end

end
