class List < ActiveRecord::Base
	belongs_to :user
	has_many :items, dependent: :destroy

    validates :user, presence: true
	validates :title, presence: true, length: { minimum: 5 }

	def completed?
		self.items_remaining == 0 && self.items.exists? 
	end

	def update_items_remaining
    	self.items_remaining = self.items.where(completed: false).count
	end

end
