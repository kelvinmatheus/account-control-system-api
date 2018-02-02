class CreateLegalPeople < ActiveRecord::Migration[5.1]
  def change
    create_table :legal_people do |t|
      t.string :cpf, null: false, unique: true, limit: 11
      t.string :name, null: false, limit: 70
      t.date :birthdate, null: false

      t.timestamps
    end

    add_index 'legal_people', [:cpf], name: 'index_cpf_unique', unique: true
  end
end
