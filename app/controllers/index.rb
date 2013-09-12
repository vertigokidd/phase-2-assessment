# GET ====================================


get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/user/:user_id' do
  @user = User.find(params[:user_id])
  erb :profile
end

get '/logout' do
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
  redirect "/user/#{user.id}"
end

post '/login' do
  email = params[:email]
  password = params[:password]
  user = User.find_by_email(email)
  if user.password == password
  	redirect "/user/#{user.id}"
  else
    redirect '/'
  end
end