LinkBase::Application.routes.draw do
  resources :links

  root "links#index"

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
end
