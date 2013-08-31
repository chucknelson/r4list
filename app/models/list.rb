class List < ActiveRecord::Base
	belongs_to :user
	has_many :items, dependent: :destroy

	validates :title, presence: true, length: { minimum: 5 }

	def items_remaining
		self.items.where(completed: false).count
	end

	def completed?
		self.items_remaining == 0
	end

end
