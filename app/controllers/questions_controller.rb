class QuestionsController < ApplicationController
  # Public methods in Controllers are called `actions`.
  # They are used to get data from models and show
  # views to the users.
  def new
    # Only controllers should interact with the Model. Define all of your
    # model instances in here and pass as instance variables to your views.
    @question = Question.new
  end

  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def create
    # Use `render json: params` to help you understand what data your
    # action is receiving.
    # render json: params

    # If you want to pass variables to views, you must define them as
    # instance variables. That is prefix `@` in front of their name. Local
    # variables are inaccessible inside views.
    @question = Question.new question_params

    # With the gem `pry` installed, you can use the `binding.pry` command
    # to stop a program at that line and open it in a `pry` console. This very
    # to debug and understand programs.
    # binding.pry

    if @question.save
      redirect_to home_path
    else
      render :new
    end
  end

  def show
    @question = Question.find params[:id]
    # Implement view count feature. It should increment the view_count
    # column anytime a question is viewed
    @question.update(view_count: @question.view_count + 1)
    # Alternate:
    # @question.view_count += 1
    # @question.save
  end

  def edit
    @question = Question.find params[:id]
  end

  def update
    @question = Question.find params[:id]

    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find params[:id]
    @question.destroy

    redirect_to questions_path
  end

  private
  def question_params
    params.require(:question).permit(:title, :body)
  end
end





#bump
