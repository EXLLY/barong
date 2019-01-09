class AddSubscribedToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :subscribed, :boolean, default: false
  end
end
