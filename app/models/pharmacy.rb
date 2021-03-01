class Pharmacy < ActiveRecord::Base

    belongs_to :user
    has_many :medications, through: :users
end
