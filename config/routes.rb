Rails.application.routes.draw do

  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    namespace :v1 do
      resources :legal_people
      resources :juridical_people
      resources :accounts do
        patch :unblock, on: :member, as: :account_unblock
        resources :transactions, only: %i[index show create]
      end

    end
  end
end
