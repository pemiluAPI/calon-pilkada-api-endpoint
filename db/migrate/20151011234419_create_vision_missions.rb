class CreateVisionMissions < ActiveRecord::Migration
  def change
    create_table :vision_missions do |t|
      t.references	:candidate
      t.text	:vision
      t.text	:mission
      t.text	:resource
      t.timestamps
    end
  end
end
