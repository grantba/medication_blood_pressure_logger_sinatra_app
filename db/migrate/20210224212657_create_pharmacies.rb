class CreatePharmacies < ActiveRecord::Migration[5.2]
  def change
    create_table :pharmacies do |t|
      t.string :name
      t.text :address
      t.string :phone_number
      t.string :website
      t.text :notes
      t.integer :user_id
    end
  end
end
