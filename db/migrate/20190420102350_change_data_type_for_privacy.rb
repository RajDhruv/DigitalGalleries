class ChangeDataTypeForPrivacy < ActiveRecord::Migration[5.2]
  def self.up
  	change_table :paintings do|t|
  		t.change :privacy, :integer
  	end
  end
end
