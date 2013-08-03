class Item < ActiveRecord::Base
  belongs_to :list

  validates :name, presence: true

  def status
  	self.completed ? 'Complete' : 'Incomplete'
  end

end
