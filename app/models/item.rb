class Item < ActiveRecord::Base
  belongs_to :list

  validates :list, presence: true
  validates :name, presence: true

  after_save :update_list_items_remaining 
  # after_destroy :update_list_items_remaining

  # TODO: Delete...is this even used?
  # def status
  # 	self.completed ? 'Complete' : 'Incomplete'
  # end

  def update_list_items_remaining
    self.list.update_items_remaining
    self.list.save
  end

end
