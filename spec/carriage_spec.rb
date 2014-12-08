require 'carriage'

describe Carriage do

  let (:carriage) { Carriage.new(train: train) }
  let (:station) { double :station }
  let (:train) { double :train, current_station: station, carriages: [] }
  let (:passenger) { double :passenger, current_station: station, has_insufficient_credit?: false }

  context "its capacity" do

    it "should have a passenger capacity of 40" do
      expect(carriage.passenger_capacity).to eq(40)
    end

  end

  context "its train" do

    it "should be added to its train's carriages" do
      expect(train.carriages).to include(carriage)
    end

    it "should have the same current station as its train" do
      expect(carriage.current_station).to eq(train.current_station)
    end

  end

  context "alighting and boarding" do

    it "should allow a passenger to board" do
      allow(station).to receive(:release_passenger)
      expect(passenger).to receive(:current_station=)
      carriage.accept_board(passenger)
      expect(carriage.passenger_count).to eq(1)
    end

    it "should not allow a passenger to board a carriage before it touches in at the station" do
      passenger_outside_station = double :passenger, current_station: nil
      allow(station).to receive(:release_passenger)
      expect(lambda { carriage.accept_board(passenger_outside_station) }).to raise_error("Cannot board")
    end

    it "should not allow a passenger to board a carriage of a train which is not at the same station as he/she" do
      passenger_at_different_station = double :passenger, current_station: 'different_station'
      expect(lambda { carriage.accept_board(passenger_at_different_station) }).to raise_error("Cannot board")
    end

    it "should allow a passenger to alight" do
      allow(station).to receive(:release_passenger)
      expect(passenger).to receive(:current_station=)
      carriage.accept_board(passenger)
      allow(station).to receive(:receive_passenger)
      allow(station).to receive(:is_full_of_passengers?)
      expect(passenger).to receive(:current_station=)
      carriage.accept_alight(passenger)
      expect(carriage.passenger_count).to eq(0)
    end

  end

end
