class AddNotifyMeToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :notify_me, :boolean, default: false
  end
end
