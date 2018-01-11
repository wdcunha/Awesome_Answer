class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  # Public methods in Controllers are called `actions`.
  # They are used to get data from models and show
  # views to the users.
  def new
    # Only controllers should interact with the Model. Define all of your
    # model instances in here and pass as instance variables to your views.
    @question = Question.new
  end

  def index
    # @questions = Question.all.order(created_at: :desc)
    @liked = params[:liked]
    if @liked
      @questions = current_user.liked_questions
    else
      @questions = Question.all.order(created_at: :desc)
    end
  end

  def create
    # Use `render json: params` to help you understand what data your
    # action is receiving.
    # render json: params

    # If you want to pass variables to views, you must define them as
    # instance variables. That is prefix `@` in front of their name. Local
    # variables are inaccessible inside views.
    @question = Question.new question_params
    # @question.user_id = current_user
    @question.user = current_user

    # With the gem `pry` installed, you can use the `binding.pry` command
    # to stop a program at that line and open it in a `pry` console. This very
    # to debug and understand programs.
    # binding.pry

    if @question.save
      # redirect_to home_path

      # `redirect_to` can also take a model instance as an argument.
      # When it gets a model instance, it will redirect the user to its
      # show page which requires that the relevant route is defined.
      redirect_to @question
    else
      render :new
    end
  end

  def show
    # Implement view count feature. It should increment the view_count
    # column anytime a question is viewed
    @question.update(view_count: @question.view_count + 1)
    # Alternate:
    # @question.view_count += 1
    # @question.save
    @answers = @question.answers.order(created_at: :desc)
    @answer = Answer.new
    # @user_like = current_user.likes.find_by_question_id(@question)
    @user_like = current_user.likes.find_by_question_id(@question) if user_signed_in?
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy

    redirect_to questions_path
  end

  private
  def question_params
    params.require(:question).permit(:title, :body)
  end

  def find_question
    @question = Question.find params[:id]
  end


  def authorize_user!
    # When using cancancan methods like `can?`, it knows
    # the logged in user as long as the method `current_user`
    # is defined for controllers.
            unless can?(:manage, @question)
      flash[:alert] = "Access Denied!"
      redirect_to home_path
    end
  end
end




#bump
