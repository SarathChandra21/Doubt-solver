class AddAnotherNotify < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :notify_me, :int, default: 0
  end
end
