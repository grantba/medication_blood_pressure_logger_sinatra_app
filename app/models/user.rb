class User < ActiveRecord::Base

    has_secure_password
    has_many :blood_pressure_readings
    has_many :medications
    has_many :physicians
    has_many :pharmacies

    def self.find_by_matched_slug(slug)
        User.all.find {|user| user.username.downcase == slug.downcase}
    end
    
end
