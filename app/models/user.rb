# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  user_name  :string(255)
#  email      :string(255)
#  first_name :string(255)
#  last_name  :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :user_name, :email, :first_name, :last_name, :password, :password_confirmation
  has_many :meetings
  has_many :contacts
  has_secure_password

  validates :user_name, presence: true, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false }
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: valid_email_regex }
  validates :password, length: { minimum: 6}

  def today_shedule
    Meeting.where("date(date_time) = date(?) and user_id = ?", DateTime.now, id)
  end

  def search_meetings contact_name
    contact_name = contact_name || ''
    contact_query = "(contacts.first_name LIKE :name_regex or contacts.last_name LIKE :name_regex)"
    query = contact_query + " and meetings.user_id = :user_id"
    Meeting.joins(:contacts).where(query, {name_regex: '%' + contact_name + '%', user_id: id}).uniq
  end

end
