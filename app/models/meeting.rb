class Meeting < ActiveRecord::Base
  attr_accessible :date_time, :place, :category_id, :notes, :contact_ids
  belongs_to :user
  belongs_to :category
  has_and_belongs_to_many :contacts

  validates :date_time, presence: true
  validates :notes, presence: true
  validate :date_time_is_in_the_future

  def date_time_is_in_the_future
    if date_time.past?
      errors.add(:date_time, "can't be scheduled for past moment in time.")
    end
  end

  default_scope order: 'date_time ASC'
end
