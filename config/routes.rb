Rails.application.routes.draw do

  scope "/:locale" do
    get 'static_pages/ico_landing'
    root 'static_pages#ico_landing'

  end
  root 'static_pages#ico_landing'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
