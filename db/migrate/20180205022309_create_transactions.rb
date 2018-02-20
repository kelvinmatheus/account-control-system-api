class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :transactional_code, null: false, unique: true
      t.integer :type, null: false, limit: 1
      t.decimal :value, null: false, precision: 10, scale: 2
      t.references :origin_account, foreign_key: { to_table: :accounts }, null: false, index: true
      t.decimal :origin_account_value_before_transaction, null: false, precision: 10, scale: 2
      t.references :destination_account, foreign_key: { to_table: :accounts }, index: true
      t.decimal :destination_account_value_before_transaction, precision: 10, scale: 2

      t.timestamps
    end

    add_index :transactions, [:transactional_code], name: 'index_transactional_code_unique', unique: true

  end
end
