class CreateFamilyMembers < ActiveRecord::Migration
  def change
    create_table :family_members do |t|

      t.timestamps null: false
    end
  end
end
