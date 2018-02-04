class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name, null: false, unique: true, limit: 70
      t.decimal :balance, null: false, default: 0, precision: 10, scale: 2
      t.integer :status, null: false, default: 2, limit: 1
      t.belongs_to :person, polymorphic: true

      t.timestamps
    end

    add_index :accounts, [:name], name: 'index_name_unique', unique: true
  end
end
