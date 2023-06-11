class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :que
      t.text :ans
      t.timestamps
    end
  end
end
