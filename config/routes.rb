Rails.application.routes.draw do

  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    namespace :v1 do
      resources :legal_people
      resources :juridical_people
    end
  end
end
