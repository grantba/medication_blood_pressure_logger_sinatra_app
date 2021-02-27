class Physician < ActiveRecord::Base

    has_and_belongs_to_many :users
    has_many :medications, through: :users
end
