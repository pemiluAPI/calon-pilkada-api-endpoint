class Region < ActiveRecord::Base
	has_many :candidates
	belongs_to :province
end
