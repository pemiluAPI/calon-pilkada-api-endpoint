class AddIdParticipantToVisionMissions < ActiveRecord::Migration
  def change
    add_column :vision_missions, :id_participant, :string
  end
end
