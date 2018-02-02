FactoryBot.define do
  factory :legal_person, aliases: [:valid_legal_person] do
    cpf { Faker::Number.number(11) }
    sequence(:name, 'a') { |l| Faker::Name.name + l }
    birthdate { Date.today.strftime('%Y-%m-%d') }

    factory :invalid_legal_person do
      id { 0 }
      cpf { Faker::Number.number(10) }
      name { '' }
      birthdate { (DateTime.now + 1.day).strftime('%Y-%m-%d') }
    end
  end
end
