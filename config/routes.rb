Rails.application.routes.draw do
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  devise_for :users, controllers: { registrations: 'registrations' }

  root 'pages#welcome'

  resources :events, concerns: :paginatable do
    get :open_replies_mail, on: :member
    get :close_replies_mail, on: :member
    post :open, on: :member
    post :open_with_mail, on: :member
    post :close, on: :member
    post :close_with_mail, on: :member

    resources :replies, only: [:index] do
      get :edit_multiple, on: :collection
      put :update_multiple, on: :collection
    end
  end

  resources :league_matches,
    controller: 'events',
    type: 'LeagueMatch',
    only: [:create, :edit, :update]
  resources :cup_matches,
    controller: 'events',
    type: 'CupMatch',
    only: [:create, :edit, :update]
  resources :others,
    controller: 'events',
    type: 'Other',
    only: [:create, :edit, :update]

  resources :forum_threads

  resources :news, concerns: :paginatable

  resources :players, concerns: :paginatable, except: :destroy do
    get :for_user, on: :new
  end

  resources :replies, only: [:create, :update]

  resources :reports, concerns: :paginatable, except: :destroy do
    get :no_content, on: :collection
    get :missing, on: :collection
  end

  resources :users, only: [:index, :update]

  resources :user_profiles, only: [:index, :show, :edit, :update]

  resources :teams, except: :show

  get '/fussball_de' => 'pages#fussball_de'
  get '/contact' => 'pages#contact'
end
