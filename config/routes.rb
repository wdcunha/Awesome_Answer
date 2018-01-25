Rails.application.routes.draw do
  # namespace will automatically prefix routes with the first argument.
  # Meaning that the route below will all question routes
  # with /api/v1/ in front.
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :questions
    end
  end


  match "/delayed_job", to: DelayedJobWeb, anchor: false, via: [:get, :post]

  resources :surveys, only: [:new, :create]

  # Admin related routes
  namespace :admin do
    # The `namespace` method takes a symbol as a first argument and a block
    # as an argument. It will prefix all routes defined inside the block
    # with the symbol given as a first argument.

    # It will also expect to find the related controllers in a subdirectory
    # named after the symbol (i.e. controllers/admin/...)

    # As well, it will expect said controllers to be part of a module
    # named after the symbol (i.e. Admin::DashboardController)
    resources :dashboard, only: [:index]
  end

  # session related routes
  # different of answer, we have just one session per user
  #
  resource :session, only: [:new, :create, :destroy]

  # User related routes
   resources :users, only: [:new, :create, :show, :index]

  # Question related routes


  resources :questions  do
    # TODO: idaelly we should make the answers as shallow: true which requires
    # some changes in the views and possibly controllers
    resources :answers, only: [:create, :destroy]
    resources :answers, only: [], shallow: true do
      resources :stars, only: [:create, :destroy], shallow: true
    end
    resources :likes, only: [:create, :destroy], shallow: true
    resources :votes, only: [:create, :update, :destroy], shallow: true
  end
  # The `resources` will generate all CRUD REST conventions
  # routes we did below for any resource.

  # get('/questions/new', to: 'questions#new', as: :new_question)
  # post('/questions/', to: 'questions#create', as: :questions)
  # get('/questions/', to: 'questions#index')
  # When generating routes with matchable sections (i.e :id, :name, :question_id),
  # you must provide its url/path generate method an argument which replace that
  # that matchable section.
  # To use the route below, we would write `question_path(question.id)` or
  # `question_path(question)` or `question_url(20)`

#### substituted for resources : questions
  # get('/questions/:id', to: 'questions#show', as: :question)
  # get('/questions/:id/edit', to: 'questions#edit', as: :edit_question)
  # patch('/questions/:id', to: 'questions#update')
  # delete('/questions/:id', to: 'questions#destroy')

  # the line below defines a Rails route. The routes says here: if we receive
  # an HTTP, GET request with url `/` (home page) then handle the request with
  # the WelcomeController using the index action (method in the the controller)
  # `as: :home` will generate a url helper: home_path that maps to the same url
  get('/', { to: 'welcome#index', as: :home })

  get('/about', { to: 'welcome#about' })

  get('/contact', { to: 'contact#new' })
  post('/contact_submit', { to: 'contact#create' })
end
