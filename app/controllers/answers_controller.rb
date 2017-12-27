get '/users/:id/answers' do
	if logged_in?
		@question = Question.find_by(id: params[:id])
		@user = User.find_by(id: params[:id])
		@answers = Answer.where(user_id: @user.id).order(updated_at: :desc)
		@answer = Answer.find_by(id: params[:id])
		erb :"answers/answer"
	else
		redirect '/'
	end 
end

post '/questions/:id/answers' do
	@question = Question.find_by(id: params[:id])
	@answers_list = Answer.where(question_id: params[:id]).order(updated_at: :desc)
	table_column = {
		:description => params[:answer][:description],
		:user_id => current_user.id,
		:question_id => @question.id
	}
	@answer = Answer.new(table_column)
	if @answer.save
		erb :"questions/show_questions_answers"
	else
		erb :"static/index"
	end
end	

get '/answers/:id/edit' do
	if logged_in?
	@answer = Answer.find_by(id: params[:id])
	erb :"answers/edit_answer"
	else
	erb :"static/index"	
	end
end

post '/answers/:id' do
	@answer = Answer.find(params[:id])
	@answer.update(params[:answer])
	redirect to '/questions/' + @answer.question_id.to_s
end

post '/answers/:id/destroy' do
	@answer = Answer.find(params[:id])
	@answer.destroy
	redirect to '/questions/' + @answer.question_id.to_s
end