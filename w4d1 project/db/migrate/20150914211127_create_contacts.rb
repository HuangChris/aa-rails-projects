class CreateContacts < ActiveRecord::Migration
  def change
    change_column :users, :username, :string, null: false

    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :contacts, [:user_id, :email], unique: true

    create_table :contact_shares do |t|
      t.integer :contact_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :contact_shares, [:contact_id, :user_id], unique: true
    add_index :contact_shares, :user_id

  end
end
