class Event < ActiveRecord::Base
	has_many :attendances
	has_many :teams, through: :attendances

	validates :name,presence: true,uniqueness: true

end
