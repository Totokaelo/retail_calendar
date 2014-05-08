module RetailCalendar
  class RangeFinder

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
      start_month.upto(start_month + month_diff - 1) do |current_month|
        start_time += weeks_in_month(current_month % 12).weeks
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
      year = year.to_i
      jan31 = DateTime.new(year,1,31)
      jan31day = jan31.cwday
      if jan31day < 3
        start = jan31 - jan31day
      elsif jan31day < 7
        start = jan31 + (7 - jan31day)
      elsif jan31day == 7
        start = jan31
      end
      start
    end

    def self.weeks_in_month(month)
      # every 3rd month (mar/jun/sep/dec) is a 5 week month
      month % 3 == 0 ? 5 : 4
    end

    def self.year_has_extra_week?(year)
      year = year.to_i
      expected = self.start_time_for_year(year) + 364
      actual = self.start_time_for_year(year + 1)
      actual > expected ? true : false
    end
  end
end
