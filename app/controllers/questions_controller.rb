get '/users/:id/questions' do
	if logged_in?
		@user = User.find_by(id: params[:id])
		@questions = Question.where(user_id: @user.id).order(updated_at: :desc)
		@question = Question.find_by(id: params[:id])
		erb :"questions/question"
	else
		redirect '/'
	end 
end

get '/questions/new' do
	if logged_in?
		erb :"questions/new"
	else
		redirect '/'
	end
end

post '/questions' do
	@question = current_user.questions.new(params[:question])
	if @question.save
		redirect "/users/#{@question.user_id}/questions"
	else
		erb :"questions/new"
	end
end

get '/questions/:id' do
	@question = Question.find_by(id: params[:id])
	@answers_list = Answer.where(question_id: params[:id]).order(updated_at: :desc)
	  if @question.nil?
	  	redirect '/'
	  else
  		erb :"questions/show_questions_answers"
  	  end
end

get '/questions/:id/edit' do
	if logged_in?
	@question = Question.find_by(id: params[:id])
	erb :"questions/edit_question"
	else
	erb :"static/index"	
	end
end

post '/questions/:id' do
	@question = Question.find(params[:id])
	@question.update(params[:question])
	redirect "/users/#{@question.user_id}/questions"
end

post '/questions/:id/destroy' do
	@question = Question.find(params[:id])
	@question.destroy
	redirect "/users/#{@question.user_id}/questions"
end