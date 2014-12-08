require 'station'

describe Station do

  let (:station) { Station.new }
  let (:train) { double :train }
  let (:passenger) { double :passenger, has_insufficient_credit?: false }
  

  def fill_station_with_trains
    2.times { station.receive_train(train) }
  end

  context "train capacity" do

    it "should have a default train capacity if none is specified" do
      expect(station.train_capacity).to eq(2)
    end

    it "should allow setting the train capacity on initializing" do
      second_station = Station.new(train_capacity: 6)
      expect(second_station.train_capacity).to eq(6)
    end

  end

  context "passenger capacity" do

    it "should have a default passenger capacity if none is specified" do
      expect(station.passenger_capacity).to eq(40)
    end

    it "should allow setting the passenger capacity on initializing" do
      third_station = Station.new(passenger_capacity: 300)
      expect(third_station.passenger_capacity).to eq(300)
    end

  end

  context "receiving trains" do

    it "should not have a train on initializing" do
      expect(station.train_count).to eq(0)
    end

    it "should be able to receive a train" do
      station.receive_train(train)
      expect(station.train_count).to eq(1)
    end

    it "should know when it's full of trains" do
      fill_station_with_trains
      expect(station).to be_full_of_trains
    end

    it "cannot receive more than trains than its capacity" do
      fill_station_with_trains
      expect(lambda { station.receive_train(train)} ).to raise_error("Station full")
    end

  end

  context "releasing trains" do

    it "should be able to release a train" do
      station.receive_train(train)
      station.release_train(train)
      expect(station.train_count).to eq(0)
    end

  end

  context "passengers entering and exiting stations" do

    it "should allow a passenger to enter" do
      expect(passenger).to receive(:current_station=).with(station)
      station.allow_enter(passenger)
      expect(station.passenger_count).to eq(1)
    end

    it "should allow a passenger to exit" do
      allow(passenger).to receive(:current_station=).with(station)
      station.allow_enter(passenger)
      expect(passenger).to receive(:current_station=).with(nil)
      station.allow_exit(passenger)
      expect(station.passenger_count).to eq(0)
    end

  end

end
