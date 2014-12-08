require 'station'

describe Station do

  let (:station) { Station.new(train_capacity: 6, passenger_capacity: 300) }
  let (:train) { double :train, is_a?: Train }
  let (:passenger) { double :passenger }
  

  def fill_station_with_trains
    6.times { station.receive_train(train) }
  end

  context "train capacity" do

    it "should have a default train capacity if none is specified" do
      default_station = Station.new
      expect(default_station.train_capacity).to eq(2)
    end

    it "should allow setting the train capacity on initializing" do
      expect(station.train_capacity).to eq(6)
    end

  end

  context "passenger capacity" do

    it "should have a default passenger capacity if none is specified" do
      default_station = Station.new
      expect(default_station.passenger_capacity).to eq(40)
    end

    it "should allow setting the passenger capacity on initializing" do
      expect(station.passenger_capacity).to eq(300)
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
      expect(lambda { station.receive_train(train)} ).to raise_error(RuntimeError)
    end

  end

  context "releasing trains" do

    it "should be able to release a train" do
      station.receive_train(train)
      station.release_train(train)
      expect(station.train_count).to eq(0)
    end

    it "should not release a train which isn't there" do
      expect(lambda {station.release_train(train)} ).to raise_error(RuntimeError)
    end

  end

  context "passengers touching in and out of stations" do

    it "should allow a passenger to touch in" do
      expect(station).to receive(:receive_passenger)
      expect(passenger).to receive(:current_station=).with(station)
      station.allow_touch_in(passenger)
    end

    it "should allow a passenger to touch out" do
      allow(station).to receive(:receive_passenger)
      allow(passenger).to receive(:current_station=).with(station)
      station.allow_touch_in(passenger)
      expect(station).to receive(:release_passenger)
      expect(passenger).to receive(:current_station=).with(nil)
      station.allow_touch_out(passenger)
    end

  end

end
