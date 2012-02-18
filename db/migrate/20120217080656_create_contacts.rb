class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.datetime :birthday
      t.string :phone_number
      t.string :address
      t.string :notes

      t.timestamps
    end
  end
end
