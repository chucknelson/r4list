class Item < ActiveRecord::Base
  belongs_to :list

  validates :name, presence: true

  after_update :update_list_items_remaining 

  def status
  	self.completed ? 'Complete' : 'Incomplete'
  end

  def update_list_items_remaining
    self.list.update_items_remaining
    self.list.save
  end

end
