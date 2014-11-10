require 'passenger'

describe Passenger do
  
  let (:passenger) { Passenger.new }
  let (:passenger_with_low_credit) { Passenger.new(credit: 1) }
  let (:station) { double :station }
  let (:train) { double :train, current_station: station }
  let (:carriage) { double :carriage, train: train, current_station: station }

  context "passenger credit" do

    it "should have a default credit on initializing" do
      expect(passenger.credit).to eq(10)
    end

    it "should allow his/her credit to be set on initializing" do
      expect(passenger_with_low_credit.credit).to eq(1)
    end

  end

  context "touching in and out of stations" do

    it "should be able to touch in at a station" do
      expect(station).to receive(:receive_passenger).with(passenger)
      passenger.touch_in(station)
    end

    it "should be able to touch out at a station" do
      expect(station).to receive(:release_passenger).with(passenger)
      passenger.touch_out(station)
    end

  end

  context "boarding carriages" do

    it "should be should be released from a station when he/she boards a carriage" do
      allow(station).to receive(:receive_passenger).with(passenger)
      passenger.touch_in(station)
      expect(station).to receive(:release_passenger).with(passenger)
      allow(carriage).to receive(:receive_passenger).with(passenger)
      passenger.board(carriage)
    end

    it "should be received by the carriage when he/she boards it" do
      allow(station).to receive(:receive_passenger).with(passenger)
      passenger.touch_in(station)
      allow(station).to receive(:release_passenger).with(passenger)
      expect(carriage).to receive(:receive_passenger).with(passenger)
      passenger.board(carriage)
    end

    it "should not be able to board a carriage before it touches in at the station" do
      expect(lambda { passenger.board(carriage) }).to raise_error(RuntimeError)
    end

    it "should not be able to board a carriage of a train which is not at the same station as he/she" do
      second_station = double :station 
      second_train = double :train, current_station: second_station
      second_carriage = double :carriage, train: second_train, current_station: second_station
      allow(station).to receive(:receive_passenger).with(passenger)
      passenger.touch_in(station)
      expect(lambda { passenger.board(second_carriage) }).to raise_error(RuntimeError)
    end

  end

  context "alighting carriages" do

    it "should be released by a carriage when he/she alights" do
      expect(carriage).to receive(:release_passenger).with(passenger)
      allow(station).to receive(:receive_passenger).with(passenger)
      passenger.alight(carriage)
    end

    it "should be received by the station when he/she alights" do
      allow(carriage).to receive(:release_passenger).with(passenger)
      expect(station).to receive(:receive_passenger).with(passenger)
      passenger.alight(carriage)
    end

  end

end
