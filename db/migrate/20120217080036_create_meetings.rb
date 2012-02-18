class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.integer :user_id
      t.integer :category_id
      t.datetime :date_time
      t.string :place
      t.string :notes

      t.timestamps
    end
  end
end
