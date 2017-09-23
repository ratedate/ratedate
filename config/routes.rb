Rails.application.routes.draw do


  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/, defaults: {locale: "ru"}  do
    get 'static_pages/home'
    get 'static_pages/in_develop'
    root 'static_pages#in_develop'
  end
  constraints subdomain: 'ico' do
    scope module: 'ico' do
      scope "/:locale", locale: /#{I18n.available_locales.join("|")}/, defaults: {locale: "ru"}  do
        get 'static_pages/ico_landing'
        root 'static_pages#ico_landing'
      end
      root 'static_pages#ico_landing'
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
    root 'static_pages#ico_landing', module: 'ico'
  end

  root 'static_pages#in_develop'
end
