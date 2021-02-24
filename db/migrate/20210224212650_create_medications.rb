class CreateMedications < ActiveRecord::Migration
  def change
    create_table :medications do |t|

      t.timestamps null: false
    end
  end
end
