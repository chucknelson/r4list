class Item < ActiveRecord::Base
  belongs_to :list

  validates :name, presence: true
  #TODO: Create failing test before implementing this validation
  #validates_associated :list

  after_save :update_list_items_remaining 
  after_destroy :update_list_items_remaining

  def status
  	self.completed ? 'Complete' : 'Incomplete'
  end

  def update_list_items_remaining
    self.list.update_items_remaining
    self.list.save
  end

end
