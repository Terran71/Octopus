Rails.application.routes.draw do
  resources :home, except: [:show]
  get 'home/insides', to: 'home#insides', as: :home_insides
  get 'home/no_access', to: 'home#no_access', as: :no_access


  resources :events
  resources :project_restrictions
  resources :project_dates
  root 'home#index'


  #Omniauth
  

  # devise_for :users, path: 'auth', :controllers => { :registrations => 'users/registrations',   
  #   :confirmations => 'users/confirmations', :sessions => 'users/sessions', 
  #   :passwords => 'users/passwords', omniauth_callbacks: "users/omniauth_callbacks"}

  # devise_scope :user do
  #   patch "auth/confirm" => "users/confirmations#confirm"
  #   delete "auth/sign_out" => "users/sessions#destroy"
  #   get "auth/sign_up", to: 'users/registrations#new'
  #   get '/devise/registrations/signup_success', to: 'users/registrations#signup_success', as: :signup_success
  #   delete 'sign_out', :to => 'users/sessions#destroy'
  #   get ':provider/callback', to: 'users/sessions#create'
  #   get 'failure', to: redirect('/')
  #   get 'signout', to: 'users/sessions#destroy', as: 'signout'

  # end

  devise_for :users, path: '', :controllers => { :registrations => 'users/registrations',   
    :confirmations => 'users/confirmations', :sessions => 'users/sessions', 
    :passwords => 'users/passwords', omniauth_callbacks: "users/omniauth_callbacks"}



  devise_scope :user do
    patch "confirm" => "users/confirmations#confirm"
    delete "sign_out" => "users/sessions#destroy"
    post "sign_in" => "users/sessions#create"

    get "sign_up", to: 'users/registrations#new'
    get '/devise/registrations/signup_success', to: 'users/registrations#signup_success', as: :signup_success
    delete 'auth/sign_out', :to => 'users/sessions#destroy'
    # get ':provider/callback', to: 'users/sessions#create'
    get 'failure', to: redirect('/')
    get 'signout', to: 'users/sessions#destroy', as: 'signout'

  end



  namespace :inside do
     resources :dashboard, only: [:index]
     # resources :no_access_logs, only: [:index, :show]
     resources :blog_posts
     resources :blog_post_lives, :controller => 'blog_posts'
     resources :blog_post_versions, :controller => 'blog_posts'

     resources :blog_authors, only: []
     resources :blog_references, only: []
     resources :social_accounts
     resources :social_sharing

  end
  # get '/page/:page_id' => 'site#page', as: :site_page

  resources :projects, except: [:new]
  resources :new_baby_meal_delivery_projects, :controller => 'projects', except: [:new]
  get 'projects/kinds', to: 'projects#kinds', as: :project_kinds

  get 'projects/new/:project_type_code/:participant_role_code', to: 'projects#new', as: :new_project

  get 'projects/roles/:project_type_code', to: 'projects#roles', as: :role_project

  resources :projects , except: [:new] do 
    get 'recipients', to: 'projects#recipients', as: :add_recipients

    resources :dashboard, only: [:index]
    resources :invites, only: [:show]
    get 'resend_invite/:id', to: 'invites#resend_invite', as: :resend_invite

    resources :participants
    resources :project_dates, only: [:show]
    patch 'add_event/:project_date_id', to: 'project_dates#add_event', as: :add_event
    get 'approval_response/:id/:approval', to: 'events#approval_response', as: :event_response
      resources :project_dates , except: [:new] do 
        # resources :events, except: [:create]
        # post 'events/add_event', to: 'events#add_event', as: :add_event

        
      end
 


    post 'invite_participants', to: 'participants#invite_participants', as: :invite_participants
    patch 'invite_recipients/:id', to: 'projects#invite_recipients', as: :invite_recipients

    get 'restrictions', to: 'projects#restrictions', as: :add_restrictions
    patch 'update_restrictions', to: 'projects#update_restrictions', as: :update_restrictions
    get 'available_dates', to: 'projects#available_dates', as: :available_dates
    patch 'update_available_dates', to: 'projects#update_available_dates', as: :update_available_dates
    get 'edit_date_range', to: 'projects#edit_date_range', as: :edit_date_range
    patch 'update_date_range', to: 'projects#update_date_range', as: :update_date_range

  end
  resources :events, only: [:create]
 
      # post 'events/add_event/:project_date_id/:project_id', to: 'events#add_event', as: :add_event
      post 'add_event/:project_date_id/:project_id', to: 'events#add_event', as: :add_event

  resources :invites, only: [:index,  :update]
  get 'rsvp/:id/:rsvp', to: 'invites#rsvp', as: :rsvp


  resources :feedbacks, only: [:new, :create]

  namespace :blog , path: "" do
     root  'articles#index'
     resources :articles, only: [:index, :show]
     resources :sections, only: [:index, :show]
     resources :contributors, only: [:index, :show]

  end

  # constraints({ subdomain: "blog" }) do
  #   namespace :blog , path: "" do
  #    root  'articles#index'
  #    resources :articles, only: [:index, :show]
  #    resources :sections, only: [:index, :show]
  #    resources :contributors, only: [:index, :show]

  #   end

  # end

end
