Rails.application.routes.draw do


  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/, defaults: {locale: "en"}  do
    constraints subdomain: 'ico' do
      scope module: 'ico', as: 'ico' do
        root 'static_pages#ico_landing', module: 'ico'
        get 'static_pages/ico_landing'
        get 'static_pages/in_develop'
      end
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
      root 'static_pages#ico_landing', module: 'ico'
    end
    get 'static_pages/home'
    get 'static_pages/in_develop'
    root 'static_pages#in_develop'
  end

  root 'static_pages#in_develop'
end
