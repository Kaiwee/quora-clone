get '/' do
	if logged_in?
		redirect "/home"
	else
		erb :"static/index"
	end
end

get '/signup' do
	erb :"static/signup"
end

post '/signup' do
	@user = User.new(params[:user])
	if @user.save
    # what should happen if the user is saved?
    sign_in(@user)
    redirect "/home"
  else
    # what should happen if the user keyed in invalid date?
    erb :"static/signup"
  end
end

post '/login' do
  # apply a authentication method to check if a user has entered a valid email and password
  # if a user has successfully been authenticated, you can assign the current user id to a session
  @user = User.find_by(email: params[:user][:email])
  if @user && @user.authenticate(params[:user][:password])
  	session[:user_id] = @user.id
  	redirect "/home"
  else
  	redirect '/'
  end	
end

post '/logout' do
  # kill a session when a user chooses to logout, for example, assign nil to a session
  # redirect to the appropriate page
  session[:user_id] = nil
  redirect '/'
end

# get '/static/profile' do
# 	if session[:user_id] != nil
# 		@current_user = User.find(session[:user_id])
# 		@message = "You have successfully login!"	
# 		erb :"/static/profile"
# 	else
# 		redirect '/'
# 	end
# end

get '/users/:id' do
  # some code here to find the user with the id given and render the profile page containing the user's infomation
  if logged_in?
  	@user = User.find_by(id: params[:id])
  	if @user.nil?
  		redirect '/'
  	else
  		erb :"users/profile"
  	end
  else
  	redirect '/'
  end
end

get '/home' do
	if logged_in?
		@users = User.all
    @questions = Question.all.order(updated_at: :desc)
		erb :"static/home"
	else
		redirect '/'	
	end
end

get '/profile' do
	if logged_in?
		redirect "/users/#{current_user.id}"
	else
		redirect '/'
	end  
end