class CreateFamilyMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :family_members do |t|
      t.string :name
      t.string :date_of_birth
      t.text :address
      t.string :phone_number
      t.string :email
      t.integer :user_id
    end
  end
end
