class CreateMedications < ActiveRecord::Migration[5.2]
  def change
    create_table :medications do |t|
      t.string :name
      t.string :dose
      t.string :form
      t.string :route
      t.string :time_to_be_taken
      t.string :category
      t.string :prescription_number
      t.string :date_filled
      t.string :refill_date
      t.string :discard_or_expiration_date
      t.text :side_effects
      t.text :notes
      t.integer :user_id
      t.integer :family_member_id
      t.integer :physician_id
      t.integer :pharmacy_id
    end
  end
end
