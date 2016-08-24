class Team < ActiveRecord::Base
	has_many :team_details
	has_many :participants, through: :team_details
	
	has_many :attendances
	has_many :events, through: :attendances

	

end
