class CreateBloodPressureReadings < ActiveRecord::Migration[5.2]
  def change
    create_table :blood_pressure_readings do |t|
      t.string :date
      t.string :time
      t.string :systolic_reading
      t.string :diastolic_reading
      t.string :pulse
      t.text :device_used
      t.string :site_used
      t.text :notes
      t.integer :user_id
    end
  end
end
