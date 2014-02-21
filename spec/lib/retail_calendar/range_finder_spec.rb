require 'spec_helper'

describe RetailCalendar::RangeFinder do
  describe '::for_month' do
    it "should return a correct range for a 4-week month" do
      range = described_class.for_month(2, 2014)
      start = Time.utc(2014, 2, 2, 0, 0, 0)
      finish = Time.utc(2014, 3, 1, 23, 59, 59)

      expect(range).to eq(start..finish)
    end

    it "should return a correct range for a 5-week month" do
      range = described_class.for_month(3, 2014)
      start = Time.utc(2014, 3, 2, 0, 0, 0)
      finish = Time.utc(2014, 4, 5, 23, 59, 59)

      expect(range).to eq(start..finish)
    end

    it "should return a correct range for a 53rd-week month" do
      range = described_class.for_month(1, 2018)
      start = Time.utc(2017, 12, 31, 0, 0, 0)
      finish = Time.utc(2018, 2, 3, 23, 59, 59)

      expect(range).to eq(start..finish)
    end

    it "should succeed for a spot check" do
      range = described_class.for_month(10, 2015)
      start = Time.utc(2015, 10, 4, 0, 0, 0)
      finish = Time.utc(2015, 10, 31, 23, 59, 59)

      expect(range).to eq(start..finish)
    end
  end
end
