Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # the line below defines a Rails route. The routes says here: if we receive
 # an HTTP, GET request with url `/` (home page) then handle the request with
 # the WelcomeController using the index action (method in the the controller)
 # `as: :home` will generate a url helper: home_path that maps to the same url
 get('/', { to: 'welcome#index', as: :home })


get('/about', { to: 'welcome#about' })

get('/contact', { to: 'contact#new' })
post('/contact_submit', { to: 'contact#create' })
end
