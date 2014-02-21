require 'spec_helper'

describe RetailCalendar do
  describe '::range' do
    it "should pass through to RangeFinder" do
      RetailCalendar::RangeFinder
        .should_receive(:for_month)
        .with(2, 2012)
        .and_return(:foo)

      expect(described_class.range(2, 2012)).to eq(:foo)
    end
  end
end
