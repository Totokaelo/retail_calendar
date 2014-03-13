require 'active_support/time'
require "retail_calendar/version"
require 'retail_calendar/range_finder'

module RetailCalendar
  def self.range(month, year)
    RetailCalendar::RangeFinder.for_month(month, year)
  end
end
