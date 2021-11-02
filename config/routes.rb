Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
        get '/jobs', to: 'jobs#index'
        post '/jobs', to: 'jobs#create'
        get '/jobs/:id' , to: 'jobs#show'
        patch '/jobs/:id', to: 'jobs#update'
        delete '/jobs/:id', to: 'jobs#destroy'
      end
    end
end