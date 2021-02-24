class BloodPressureReading < ActiveRecord::Base

    belongs_to :user
    belongs_to :family_member
end
