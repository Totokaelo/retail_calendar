require 'spec_helper'

describe RetailCalendar::RangeFinder do
  describe '::for_month' do
    def beginning_of_day(year, month, day)
      Time.utc(year, month, day).beginning_of_day
    end

    def end_of_day(year, month, day)
      Time.utc(year, month, day).end_of_day
    end

    it "should work in January" do
      range = described_class.for_month(1, 2014)
      start = beginning_of_day(2014, 1, 5)
      finish = end_of_day(2014, 2, 1)

      expect(range).to eq(start..finish)
    end

    it "should work in December" do
      range = described_class.for_month(12, 2015)
      start = beginning_of_day(2015, 11, 29)
      finish = end_of_day(2016, 1, 2)

      expect(range).to eq(start..finish)
    end

    it "should return a correct range for a 4-week month" do
      range = described_class.for_month(2, 2014)
      start = beginning_of_day(2014, 2, 2)
      finish = end_of_day(2014, 3, 1)

      expect(range).to eq(start..finish)
    end

    it "should return a correct range for a 5-week month" do
      range = described_class.for_month(3, 2014)
      start = beginning_of_day(2014, 3, 2)
      finish = end_of_day(2014, 4, 5)

      expect(range).to eq(start..finish)
    end

    it "should return a correct range for a 53rd-week month" do
      range = described_class.for_month(1, 2018)
      start = beginning_of_day(2017, 12, 31)
      finish = end_of_day(2018, 2, 3)

      expect(range).to eq(start..finish)
    end

    it "should succeed for a spot check" do
      range = described_class.for_month(10, 2015)
      start = beginning_of_day(2015, 10, 4)
      finish = end_of_day(2015, 10, 31)

      expect(range).to eq(start..finish)
    end
  end
end
