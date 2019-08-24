class CreateResponse < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.integer :user_id
      t.integer :answer_choice_id
    end

    add_column :questions, :poll_id, :integer
    add_column :answer_choices, :question_id, :integer
  end
end
