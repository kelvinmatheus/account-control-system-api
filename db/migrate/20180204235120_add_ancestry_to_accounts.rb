class AddAncestryToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :ancestry, :string, after: :person_id
    add_index :accounts, :ancestry
  end
end
