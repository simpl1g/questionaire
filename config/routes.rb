Apoex::Application.routes.draw do
  root "public#index"

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
end
