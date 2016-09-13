class AddItemInfoToLists < ActiveRecord::Migration
  def change
    add_column :lists, :items_remaining, :integer

    List.find_each do |list|
      list.update(items_remaining: list.items.where(completed: false).count)
    end
  end
end
