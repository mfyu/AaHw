class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.integer :shortened_url_id
      t.integer :user_id
      t.timestamp

     
    end
  end
end