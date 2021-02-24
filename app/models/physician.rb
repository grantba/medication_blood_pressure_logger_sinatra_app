class Physician < ActiveRecord::Base

    has_and_belongs_to_many :users
    has_and_belongs_to_many :family_members
    has_many :medications, through: :users
    has_many :medications, through: :family_members
end
