class Physician < ActiveRecord::Base

    belongs_to :user
    has_many :medications, through: :users
end
