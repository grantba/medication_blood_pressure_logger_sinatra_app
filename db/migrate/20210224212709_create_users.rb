class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :date_of_birth
      t.text :address
      t.string :phone_number
      t.string :email
      t.string :username
      t.string :password_digest
    end
  end
end
