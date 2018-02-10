require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let!(:legal_person_account) { create(:valid_legal_person_account) }

  let!(:origin_account) { FactoryBot.create(:valid_legal_person_account, balance: 0) }
  let!(:charge_transaction) do
    create(
      :charge_transaction, :valid_attributes,
      origin_account_id: origin_account.id,
      origin_account_value_before_transaction: origin_account.balance
    )
  end

  let!(:transactional_code) { TransactionHelper::Generator.alphanumeric_code(charge_transaction) }

  describe 'Validations' do
    context ':transactional_code' do
      it { should validate_presence_of(:transactional_code) }
      it { should validate_uniqueness_of(:transactional_code) }
      it { should validate_length_of(:transactional_code).is_equal_to(32) }
    end

    context ':value' do
      it { should validate_presence_of(:value) }
      it { should validate_numericality_of(:value).is_greater_than(0) }
    end

    context ':origin_account_id' do
      it { should validate_presence_of(:origin_account_id) }
      it { should validate_numericality_of(:origin_account_id).only_integer }
    end

    context ':origin_account_value_before_transaction' do
      it { should validate_presence_of(:origin_account_value_before_transaction) }
      it { should validate_numericality_of(:origin_account_value_before_transaction) }
    end

    context ':destination_account_id' do
      it { should validate_numericality_of(:destination_account_id).only_integer }
      it { should allow_value(nil).for(:destination_account_id) }
    end

    context ':destination_account_value_before_transaction' do
      it { should validate_numericality_of(:destination_account_value_before_transaction) }
      it { should allow_value(nil).for(:destination_account_value_before_transaction) }
    end
  end

  describe 'Associations' do
    it { should belong_to(:origin_account).class_name('Account').with_foreign_key(:origin_account_id) }
    it { should belong_to(:destination_account).class_name('Account').with_foreign_key(:destination_account_id) }
  end

  describe 'Business Rules' do
    context ':transactional_code' do

      context 'when :type is charge' do
        it 'should have a valid transactional code' do
          # It is expected the combination be a combination of Date (up to milliseconds), origin_account_id and type.
          # It is need to encrypt this combination with MD5 (Digest Algorithm)
          transaction = Transaction.new(type: :charge, value: 500, origin_account_id: legal_person_account.id)

          date = Time.now
          data_to_encrypt = date.strftime('%Y%m%d%H%M%S%L') + legal_person_account.id.to_s + 'charge'
          data_encrypted = Digest::MD5.hexdigest(data_to_encrypt)

          expect(transaction.send(:generate_transactional_code, date: date)).to eq(data_encrypted)
        end
      end

    end
  end
end
