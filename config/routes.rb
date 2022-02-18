Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
        get '/jobs', to: 'jobs#index'
        post '/jobs', to: 'jobs#create'
        get '/jobs/:id' , to: 'jobs#show'
        patch '/jobs/:id', to: 'jobs#update'
        delete '/jobs/:id', to: 'jobs#destroy'

        mount Rswag::Ui::Engine => "/api-docs"
        mount Rswag::Api::Engine => "/api-docs"
    end
  end


  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :users
    end
  end
end