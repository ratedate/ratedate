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
        get 'static_pages/in_develop'
        root 'static_pages#in_develop'
      end
      root 'static_pages#in_develop'
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
    root 'static_pages#in_develop', module: 'ico'
  end

  root 'static_pages#in_develop'
end
