require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'Validations' do
    before { create(:valid_legal_person_account) }

    context ':name' do
      it { should validate_presence_of(:name) }
      it { should allow_value('My account').for(:name) }
      it { should_not allow_value('My $uper Account!!@@@$$$').for(:name) }
      it { should validate_length_of(:name).is_at_least(2).is_at_most(70) }
    end

    context ':balance' do
      it { should validate_presence_of(:balance) }
      it { should validate_numericality_of(:balance) }
    end

    context ':status' do
      it { should validate_presence_of(:status) }
      it { should define_enum_for(:status).with(%i[canceled activated blocked]) }
    end

    context ':person_type' do
      it { should validate_presence_of(:person_type) }
    end

    context ':person_id' do
      it { should validate_presence_of(:person_id) }
    end
  end

  describe 'Associations' do
    it { should belong_to(:person) }
  end
end
