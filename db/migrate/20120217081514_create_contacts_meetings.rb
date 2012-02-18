class CreateContactsMeetings < ActiveRecord::Migration
  def change
    create_table :contacts_meetings do |t|
      t.integer :meeting_id, null:false
      t.integer :contact_id, null:false
      t.timestamps
    end

    add_index :contacts_meetings, :meeting_id
    add_index :contacts_meetings, :contact_id
    add_index :contacts_meetings, [:meeting_id, :contact_id], unique: true, name:'by_contact_meeting' 
    change_column :contacts_meetings, :created_at, :datetime, default:nil, null:true
    change_column :contacts_meetings, :updated_at, :datetime, default:nil, null:true
  end
end
