require 'faker'

User.delete_all
Event.delete_all

# Create 500 users
users = 50.times.map do
  User.create :first_name => Faker::Name.first_name,
              :last_name  => Faker::Name.last_name,
              :email      => Faker::Internet.email,
              :password   => "123",
              :birthdate  => Date.today - 15.years - rand(20000).days
end

events = 200.times.map do
  start_time = Time.now + (rand(61) - 30).days
  end_time   = start_time + (1 + rand(6)).hours

  Event.create :user_id    => users[rand(users.length)].id,
               :name       => Faker::Company.name,
               :location   => "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
               :starts_at => start_time,
               :ends_at   => end_time
end

50.times do |user_id|
  EventAttendance.create :user_id => user_id,
                         :event_id => events[rand(events.length)].id

  EventAttendance.create :user_id => user_id,
                         :event_id => events[rand(events.length)].id
end
