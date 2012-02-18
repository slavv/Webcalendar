module DatesHelper
  def self.next_occurrence date
    date_next = date.change(year: Date.today.year)  
    date_next = date_next.advance(years:1) unless date_next.future?
    date_next
  end
end