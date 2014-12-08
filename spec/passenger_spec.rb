require 'passenger'

describe Passenger do
  
  let (:passenger) { Passenger.new }
  let (:passenger_with_low_credit) { Passenger.new(credit: 1) }
  let (:station) { double :station }

  context "passenger credit" do

    it "should have a default credit on initializing" do
      expect(passenger.credit).to eq(10)
    end

    it "should allow his/her credit to be set on initializing" do
      expect(passenger_with_low_credit.credit).to eq(1)
    end

  end

  context "boarding carriages" do

    it "should allow its current station to be changed" do
      expect(passenger.current_station).to be nil
      passenger.current_station = station
      expect(passenger.current_station).to be(station)
    end

  end

end
