class AddItemInfoToLists < ActiveRecord::Migration
  def change
    add_column :lists, :items_remaining, :integer, default: 0

    List.find_each do |list|
      list.update(items_remaining: list.items.where(completed: false).count)
    end
  end
end
