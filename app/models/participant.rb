class Participant < ActiveRecord::Base
	has_many :team_details
	has_many :teams, through: :team_details

	validates :name, presence: true
	validates :email,email: true
	validates :phone,presence: true,
                 	 numericality: true,
                 	 length: { :minimum => 10, :maximum => 10 }
	validates :college, presence: true

	def full_info
		"#{name}, Participant ID: #{id} "
	end

end
