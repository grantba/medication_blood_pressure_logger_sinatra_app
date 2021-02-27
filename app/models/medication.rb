class Medication < ActiveRecord::Base

    belongs_to :user
    belongs_to :pharmacy
    belongs_to :physician
end
