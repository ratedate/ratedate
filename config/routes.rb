Rails.application.routes.draw do


  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    delete 'sign_out', to: 'devise/sessions#destroy'
    get 'sign_up', to: 'devise/registrations#new'
  end
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  constraints subdomain: 'ico' do
    scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/, defaults: {locale: "en"}  do
      scope module: 'ico', as: 'ico' do
        devise_for :users, skip: :omniauth_callbacks
        devise_scope :user do
          get 'sign_in', to: 'sessions#new'
          delete 'sign_out', to: 'sessions#destroy'
          get 'sign_up', to: 'registrations#new'
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
    get 'static_pages/home'
    get 'static_pages/in_develop'
    root 'static_pages#in_develop'
  end
end
