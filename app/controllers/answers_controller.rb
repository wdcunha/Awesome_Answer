class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question

  def create
    @answer = Answer.new(answer_params)
    @answer.question = @question
    # ð alternate to ð provided by `has_many :answers`
    # @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to question_path(@question)
    else
      @answers = @question.answers.order(created_at: :desc)
      # We can also give render a string as a first argument. When doing so,
      # we can provide a path beginning from the `/views` directory to
      # template of our choice. Here we're using to render the show
      # template from the questions subdirectory.
      render 'questions/show'
    end
  end

  def destroy
    @answer = Answer.find params[:id]
    @answer.destroy
    redirect_to question_path(@question)
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_question
    @question = Question.find params[:question_id]
  end
end
