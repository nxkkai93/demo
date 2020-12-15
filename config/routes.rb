Rails.application.routes.draw do

  root 'pages#home'
  
  get 'pages/private'

  get 'auth/developer', :as => 'developer_auth'
  get 'auth/github', :as => 'github_auth'
  match 'auth/:provider/callback' => 'session#create', :via => [:get, :post]

  get 'session/destroy', :as => 'logout'

  get 'repo/index'
  get 'repo/more'
  get 'repo/stargazers'
  get 'repo/more-stargazers'
  get 'repo/issues'
  get 'repo/more-issues'
  # get 'repo/search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
