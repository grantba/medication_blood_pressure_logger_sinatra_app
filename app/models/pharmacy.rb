class Pharmacy < ActiveRecord::Base

    has_and_belongs_to_many :user
    has_and_belongs_to_many :family_member
    has_many :medications
end
