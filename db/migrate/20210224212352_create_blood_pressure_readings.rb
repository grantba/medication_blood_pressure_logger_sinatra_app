class CreateBloodPressureReadings < ActiveRecord::Migration
  def change
    create_table :blood_pressure_readings do |t|

      t.timestamps null: false
    end
  end
end
