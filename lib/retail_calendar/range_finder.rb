module RetailCalendar
  class RangeFinder
    @@years = {
      2000 => Time.utc(2000, 1, 30),
      2001 => Time.utc(2001, 2, 4),
      2002 => Time.utc(2002, 2, 3),
      2003 => Time.utc(2003, 2, 2),
      2004 => Time.utc(2004, 2, 1),
      2005 => Time.utc(2005, 1, 30),
      2006 => Time.utc(2006, 1, 29),
      2007 => Time.utc(2007, 2, 4),
      2008 => Time.utc(2008, 2, 3),
      2009 => Time.utc(2009, 2, 1),
      2010 => Time.utc(2010, 1, 31),
      2011 => Time.utc(2011, 1, 30),
      2012 => Time.utc(2012, 1, 29),
      2013 => Time.utc(2013, 2, 3),
      2014 => Time.utc(2014, 2, 2),
      2015 => Time.utc(2015, 2, 1),
      2016 => Time.utc(2016, 1, 31),
      2017 => Time.utc(2017, 1, 29),
      2018 => Time.utc(2018, 2, 4)
    }

    @@extra_weeks = [2006, 2012, 2017]

    def self.for_month(month, year)
      month = month.to_i
      year = year.to_i

      # Which merchandise year does this fall into?
      merch_year = merchandise_year(month, year)

      # How far away is the month from the start_month?
      month_diff = month_offset_from_year_start(month)

      # Get the start time for the year.
      start_time = start_time_for_year(merch_year)

      final_month = start_month + month_diff

      # Add weeks offset
      start_month.upto(start_month + month_diff - 1) do |month|
        start_time += weeks_in_month(month % 12).weeks
      end

      # Compute end time.
      end_time = start_time + weeks_in_month(month).weeks

      # Factor in 53rd week
      if month == 1 && year_has_extra_week?(merch_year)
        end_time += 1.week
      end

      end_time = (end_time - 1.minute).end_of_day

      start_time..end_time
    end

    def self.merchandise_year(month, year)
      month = month.to_i
      year = year.to_i

      # January always ends up in the previous year's merch year.
      month == 1 ? year - 1 : year
    end

  private

    def self.start_month
      2
    end

    # How far are we from the year start?
    def self.month_offset_from_year_start(month)
      month == 1 ? 11 : month - 2
    end

    def self.start_time_for_year(year)
      @@years.fetch(year).beginning_of_day
    end

    def self.weeks_in_month(month)
      # every 3rd month (mar/jun/sep/dec) is a 5 week month
      month % 3 == 0 ? 5 : 4
    end

    def self.year_has_extra_week?(year)
      @@extra_weeks.include?(year)
    end
  end
end
