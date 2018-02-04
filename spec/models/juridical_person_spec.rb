require 'rails_helper'

RSpec.describe JuridicalPerson, type: :model do
  describe 'Validations' do
    before { create(:juridical_person) }

    context ':cnpj' do
      it { should validate_presence_of(:cnpj) }
      it { should validate_uniqueness_of(:cnpj).case_insensitive }
      it { should validate_numericality_of(:cnpj).only_integer }
      it { should validate_length_of(:cnpj).is_equal_to(14) }
    end

    context ':company_name' do
      it { should validate_presence_of(:company_name) }
      it { should allow_value('Company Name').for(:company_name) }
      it { should_not allow_value('Company $5 Name #@!').for(:company_name) }
      it { should validate_length_of(:company_name).is_at_least(2).is_at_most(70) }
    end

    context ':fantasy_name' do
      it { should validate_presence_of(:fantasy_name) }
      it { should allow_value('Fantasy Name').for(:fantasy_name) }
      it { should_not allow_value('Fantasy $5 Name #@!').for(:fantasy_name) }
      it { should validate_length_of(:fantasy_name).is_at_least(2).is_at_most(70) }
    end
  end

  describe 'Associations' do
    it { should have_many(:accounts) }
  end
end
