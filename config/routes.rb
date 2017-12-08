Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Question related routes
  get('/questions/new', to: 'questions#new', as: :new_question)
  post('/questions/', to: 'questions#create', as: :questions)
  get('/questions/', to: 'questions#index')
  # When generating routes with matchable sections (i.e :id, :name, :question_id),
  # you must provide its url/path generate method an argument which replace that
  # that matchable section.
  # To use the route below, we would write `question_path(question.id)` or
  # `question_path(question)` or `question_url(20)`
  get('/questions/:id', to: 'questions#show', as: :question)
  get('/questions/:id/edit', to: 'questions#edit', as: :edit_question)
  patch('/questions/:id', to: 'questions#update')
  delete('/questions/:id', to: 'questions#destroy')

  # the line below defines a Rails route. The routes says here: if we receive
  # an HTTP, GET request with url `/` (home page) then handle the request with
  # the WelcomeController using the index action (method in the the controller)
  # `as: :home` will generate a url helper: home_path that maps to the same url
  get('/', { to: 'welcome#index', as: :home })

  get('/about', { to: 'welcome#about' })

  get('/contact', { to: 'contact#new' })
  post('/contact_submit', { to: 'contact#create' })
end
