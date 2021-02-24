class FamilyMember < ActiveRecord::Base

    belongs_to :user
    has_many :blood_pressure_readings
    has_many :medications
    has_many :physicians
    has_many :pharmacies
end
