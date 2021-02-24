class User < ActiveRecord::Base

    has_secure_password
    has_many :family_members
    has_many :blood_pressure_readings
    has_many :medications
    has_many :physicians
    has_many :pharmacies
end
