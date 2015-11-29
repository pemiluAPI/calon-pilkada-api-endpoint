class AddIdParticipantToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :id_participant, :string
  end
end
