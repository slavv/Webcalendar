class Contact < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :birthday, :phone_number, :address, :notes
  belongs_to :user
  has_and_belongs_to_many :meetings

  validates :first_name, presence: true
  validates :last_name, presence: true
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: valid_email_regex }

  def schedule_birthday_meeting
    if birthday
      meeting = Meeting.new
      meetingDate = birthday.to_datetime.change(hour:14)
      meeting.date_time = DatesHelper.next_occurrence(meetingDate)
      meeting.category = Category.find_by_name("birthday")
      meeting.notes = "To greet " + first_name
      meeting.user_id = user_id
      meeting.contact_ids = [id]
      meeting.save
    end
  end
end
