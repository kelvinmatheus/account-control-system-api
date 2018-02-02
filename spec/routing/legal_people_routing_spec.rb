require 'rails_helper'

RSpec.describe API::V1::LegalPeopleController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/v1/legal_people', constraints: { subdomain: 'api'}).to route_to('legal_people#index')
    end

    it 'routes to #show' do
      expect(get: '/v1/legal_people/1', constraints: { subdomain: 'api'}).to route_to('legal_people#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/v1/legal_people', constraints: { subdomain: 'api'}).to route_to('legal_people#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/v1/legal_people/1', constraints: { subdomain: 'api'}).to route_to('legal_people#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/v1/legal_people/1', constraints: { subdomain: 'api'}).to route_to('legal_people#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/v1/legal_people/1', constraints: { subdomain: 'api'}).to route_to('legal_people#destroy', id: '1')
    end

  end
end
