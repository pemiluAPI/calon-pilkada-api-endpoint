class DropVisionMisions < ActiveRecord::Migration
  def change
  	drop_table :vision_misions
  end
end
