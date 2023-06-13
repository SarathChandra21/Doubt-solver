class RemoveNotifyMe < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :notify_me
  end
end
