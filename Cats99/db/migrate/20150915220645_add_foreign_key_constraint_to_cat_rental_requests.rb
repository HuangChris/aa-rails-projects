class AddForeignKeyConstraintToCatRentalRequests < ActiveRecord::Migration
  def change
    add_foreign_key :cat_rental_requests, :cats
  end
end
