class List < ActiveRecord::Base
	belongs_to :user
	has_many :items, dependent: :destroy

	validates :title, presence: true, length: { minimum: 5 }

	def items_remaining
		self.items.where(completed: false).count
	end

	def completed?
		!self.items.empty? && self.items_remaining == 0
	end

	#returns list update timestamp if list has no items
	def last_updated_ts
		self.items.maximum(:updated_at) || self.updated_at
	end

end
