Rails.application.routes.draw do

  mount ActionCable.server => '/cable'



  devise_for :users, skip: [:session, :password, :registration, :confirmation], :controllers => { omniauth_callbacks: 'omniauth_callbacks'}

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  constraints subdomain: 'ico' do
    scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/, defaults: {locale: "en"}  do
      scope module: 'ico', as: 'ico' do
        devise_for :users, skip: :omniauth_callbacks, :controllers => { registrations: "ico/registrations" }
        devise_scope :ico_user do
          get 'sign_in', to: 'sessions#new', module: 'ico'
          delete 'sign_out', to: 'sessions#destroy', module: 'ico'
          get 'sign_up', to: 'registrations#new', module: 'ico'
        end
        root 'static_pages#ico_landing', module: 'ico'
        get 'static_pages/ico_landing'
        get 'static_pages/in_develop'
        get 'account', to: 'account#index'
        post 'account/add_eth'
        post 'kyc/create'
        resources :etz_investments
      end
      root 'static_pages#ico_landing', module: 'ico'
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
    root 'static_pages#ico_landing', module: 'ico'
  end
  root 'static_pages#home'
  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/, defaults: {locale: "en"}  do
    resources :profiles, except: [:edit, :destroy]
    resources :auctions, except: [:destroy]
    get 'my_profile', to: 'profiles#show', as: 'my_profile'
    get 'my_profile/edit', to: 'profiles#edit', as: 'edit_my_profile'
    get 'my_bids', to: 'auctions#my_bids', as: 'auctions_my_bids'
    get 'auctions/:id/videodate', to: 'auctions#videodate', as: 'auctions_videodate'
    resources :personal_messages, only: [:new,  :create]
    resources :conversations, only: [:index, :show]
    root 'static_pages#in_develop'
    get 'terms_of_use', to: 'static_pages#terms_of_use'
    get 'privacy_policy', to: 'static_pages#privacy_policy'
    devise_for :users, skip: :omniauth_callbacks, :controllers => { registrations: "registrations" }
    devise_scope :user do
      get 'sign_in', to: 'devise/sessions#new'
      delete 'sign_out', to: 'devise/sessions#destroy'
      get 'sign_up', to: 'devise/registrations#new'
    end
    resources :promos, except: [:edit, :destroy]
    post 'activate_promo', to: 'promos#activate'
    post 'payment', to: 'payments#payment'
    post 'payment_result', to: 'payments#payment_result'
    get 'payment', to: 'payments#payment_redirect'
    get 'payment_result', to: 'payments#payment_redirect'
  end
  post 'process_payment_result', to: 'payments#process_payment_result'
  get 'process_payment_result', to: 'payments#payment_redirect'
  resources :conversations, only: [:index]
end
