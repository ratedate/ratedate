Rails.application.routes.draw do


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
      end
      root 'static_pages#ico_landing', module: 'ico'
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
    root 'static_pages#ico_landing', module: 'ico'
  end
  root 'static_pages#in_develop'
  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/, defaults: {locale: "en"}  do
    resources :profiles, except: [:edit, :destroy]
    get 'my_profile', to: 'profiles#show', as: 'my_profile'
    get 'my_profile/edit', to: 'profiles#edit', as: 'edit_my_profile'
    root 'static_pages#in_develop'
    devise_for :users, skip: :omniauth_callbacks, :controllers => { registrations: "registrations" }
    devise_scope :user do
      get 'sign_in', to: 'devise/sessions#new'
      delete 'sign_out', to: 'devise/sessions#destroy'
      get 'sign_up', to: 'devise/registrations#new'
    end
  end
end
