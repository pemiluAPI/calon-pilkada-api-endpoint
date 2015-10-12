class Candidate < ActiveRecord::Base
	belongs_to :province
	belongs_to :region

	has_many :participants
	has_one	:vision_mission
end
