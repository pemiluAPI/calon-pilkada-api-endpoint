class Province < ActiveRecord::Base
	has_many :regions
	has_many :candidates
end
