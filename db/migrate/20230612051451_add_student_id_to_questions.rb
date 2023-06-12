class AddStudentIdToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :student_id, :int
  end
end
