class CreateJuridicalPeople < ActiveRecord::Migration[5.1]
  def change
    create_table :juridical_people do |t|
      t.string :cnpj, null: false, unique: true, limit: 14
      t.string :company_name, null: false, unique: true, limit: 70
      t.string :fantasy_name, null: false, unique: true, limit: 70

      t.timestamps
    end
  end
end
