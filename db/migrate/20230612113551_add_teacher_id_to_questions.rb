class AddTeacherIdToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :teacher_id, :int
  end
end
