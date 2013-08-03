class AddCompletedToItems < ActiveRecord::Migration
  def change
    add_column :items, :completed, :boolean, default: false, null: false
  end
end
