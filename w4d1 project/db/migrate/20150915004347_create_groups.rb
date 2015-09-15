class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :groups, :user_id

    create_table :group_contacts do |t|
      t.integer :group_id, null: false
      t.integer :contact_id, null: false

      t.timestamps
    end

    add_index :group_contacts, :group_id
    add_index :group_contacts, :contact_id
  end
end
