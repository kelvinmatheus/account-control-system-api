require 'rails_helper'

RSpec.describe LegalPerson, type: :model do
  describe 'Validations' do
    before { create(:legal_person) }

    context ':cpf' do
      it { should validate_presence_of(:cpf) }
      it { should validate_uniqueness_of(:cpf).case_insensitive }
      it { should validate_numericality_of(:cpf).only_integer }
      it { should validate_length_of(:cpf).is_equal_to(11) }
    end

    context ':name' do
      it { should validate_presence_of(:name) }
      it { should allow_value('Andrew Yang').for(:name) }
      it { should_not allow_value('Andrew 2 100%$# Y@ng').for(:name) }
      it { should validate_length_of(:name).is_at_least(2).is_at_most(70) }
    end

    context ':birthdate' do
      let!(:valid_date) { DateTime.now.to_date }
      let!(:invalid_date) { DateTime.now.to_date + 1.day }

      it { should validate_presence_of(:birthdate) }
      it { should allow_value('2018-02-01').for(:birthdate) }

      it { should allow_value(valid_date).for(:birthdate) }
      it 'should not allow :birthdate to have future date' do
        should_not allow_value(invalid_date).for(:birthdate)
      end

    end
  end

  describe 'Associations' do
    it { should have_many(:accounts) }
  end
end
