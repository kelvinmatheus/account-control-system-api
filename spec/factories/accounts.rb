FactoryBot.define do
  factory :account do
    name { Faker::Name.name }
    balance { 0 }
    status { 2 }

    factory :valid_legal_person_account do
      person_type { 'LegalPerson' }
      person_id { FactoryBot.create(:legal_person).id }
    end

    factory :valid_juridical_person_account do
      person_type { 'JuridicalPerson' }
      person_id { FactoryBot.create(:juridical_person).id }
    end

    factory :invalid_account do
      id { 0 }
      nome { '' }
      saldo { nil }
      status { 2 }

      factory :invalid_legal_person_account do
        person_type { nil }
        person_id { nil }
      end

      factory :invalid_juridical_person_account do
        person_type { nil }
        person_id { nil }
      end
    end
  end
end
