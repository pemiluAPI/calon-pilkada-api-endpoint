class Candidate < ActiveRecord::Base
	self.primary_key = "id_participant"

	belongs_to :province
	belongs_to :region

	has_many :participants, foreign_key: :id_participant
	has_one	:vision_mission, foreign_key: :id_participant
end
