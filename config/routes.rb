Rails.application.routes.draw do
  get 'contact/form'
  get '/' => "home#top"
  get "homes/privacy" => "home#privacy"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/search" => "posts#search"
  get "posts/:id/edit" => "posts#edit"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  get "signup" => "user#new"
  get "login" => "user#login_form"
  get "users/:id" => "user#show"
  get "users/:id/edit" => "user#edit"
  post "users/:id/update" => "user#update"
  post "users/create" => "user#create"
  post "login" => "user#login"
  post "logout" => "user#logout"

  get "contact/form" => "contact#form"
  post "contact/create" => "contact#create"

end
