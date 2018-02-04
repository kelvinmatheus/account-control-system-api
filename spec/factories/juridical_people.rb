FactoryBot.define do
  factory :juridical_person, aliases: [:valid_juridical_person] do
    cnpj { Faker::Number.number(14).to_s }
    sequence(:company_name, 'a') { |l| Faker::Company.name + l }
    sequence(:fantasy_name, 'a') { |l| Faker::Company.name + l }

    factory :invalid_juridical_person do
      cnpj { Faker::Number.number(15).to_s }
      company_name { '' }
      fantasy_name { '' }
    end
  end
end
