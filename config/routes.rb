Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: "user/sessions",
    registrations: "user/registrations", as: :anvandare
  }

  resource :user, path: :anvandare

  # Scope to change urls to swedish
  scope path_names: { new: "ny", edit: "redigera" } do
    resources :addresses, path: :adresser

    resources :companies, path: :foretag

    resources :customers, path: :kunder do
      get :company, path: :foretag, on: :member
      resources :addresses, path: :adresser, on: :member

      resources :machines, path: :maskiner, on: :member do
        resources :works, path: :arbete, on: :member
      end
      resources :works, path: :maskiner, on: :member

    end
    resources :cities, path: :stader do
      post :search, :sok, on: :collection
    end

    resources :machines, path: :maskiner
    resources :machine_types, path: :typer
    resources :brands, path: :marke
    resources :products, path: :produkter do
      post :search, on: :collection, path: :sok
    end

    resources :roles
    resources :work_types, path: :arbetstyper
  end

  root "statics#index"
end
