class Question < ActiveRecord::Base
	belongs_to :user
	has_many :answers

	validates :title, presence: true, uniqueness: true
	validates :description, presence: true, uniqueness: true
end
