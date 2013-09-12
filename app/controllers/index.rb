enable :sessions

# GET ====================================


get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/user/:user_id' do
  @user = User.find(params[:user_id])
  erb :profile
end

get '/create' do
  erb :create
end

get '/edit/:event_id' do
  @event = Event.find(params[:event_id])
  erb :edit
end

get '/logout' do
  session.clear
  redirect '/'
end




# POST ===================================


post '/signup' do
  first_name = params[:first_name]
  last_name = params[:last_name]
  email = params[:email]
  birthdate = params[:birthdate]
  password = params[:password]
  user = User.create(first_name: first_name,
  	                 last_name: last_name,
  	                 email: email,
  	                 birthdate: birthdate,
  	                 password: password 
  	                 )
  session[:user_id] = user.id
  redirect "/user/#{user.id}"
end

post '/login' do
  email = params[:email]
  password = params[:password]
  user = User.find_by_email(email)
  if user.password == password
  	session[:user_id] = user.id
  	redirect "/user/#{user.id}"
  else
    redirect '/'
  end
end

post '/create' do
  event_name = params[:event_name]
  event_location = params[:event_location]
  date = params[:date].to_date
  starts_at = Time.parse("#{date} #{params[:starts_at]}")
  ends_at = Time.parse("#{date} #{params[:ends_at]}")
  user = User.find(session[:user_id])
  user.created_events.create(name: event_name,
  	                 location: event_location,
                     starts_at: starts_at,
                     ends_at: ends_at
  	                 )
  redirect "/user/#{user.id}"
end

post '/edit/:event_id' do
  user = User.find(session[:user_id])
  event = Event.find(params[:event_id])
  event_name = params[:event_name]
  event_location = params[:event_location]
  date = params[:date].to_date
  starts_at = Time.parse("#{date} #{params[:starts_at]}")
  ends_at = Time.parse("#{date} #{params[:ends_at]}")
  event.update_attributes(name: event_name,
  	                 location: event_location,
                     starts_at: starts_at,
                     ends_at: ends_at
  	                 )
  redirect "/user/#{user.id}"
end

post '/destroy/:event_id' do
  event_id = params[:event_id]
  event = Event.find(event_id)
  event.destroy
  redirect "/user/#{session[:user_id]}"
end




