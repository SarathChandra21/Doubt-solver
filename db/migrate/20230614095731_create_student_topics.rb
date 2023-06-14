class CreateStudentTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :student_topics do |t|
      t.integer :student_id
      t.integer :topic_id
    end
  end
end
