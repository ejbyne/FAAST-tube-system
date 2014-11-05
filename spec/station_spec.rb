require 'station'

describe Station do

  let (:station) { Station.new(train_capacity: 6, passenger_capacity: 300) }
  let (:train) { double :train, is_a?: Train }

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

    it "should only receive trains with receive_train" do
      expect(lambda { station.receive_train(:not_a_train) }).to raise_error(RuntimeError)
    end

    it "should raise an error if empty argument is passed to receive_train" do
      expect(lambda {station.receive_train()} ).to raise_error(RuntimeError)
    end

    it "should only accept one train at at time" do
      station.receive_train(train, train)
      expect(station.train_count).to eq(1)
    end

  end

  context "releasing trains" do

    it "should be able to release a train" do
      station.receive_train(train)
      station.release_train(train)
      expect(station.train_count).to eq(0)
    end

    it "should only release one train at a time" do
      second_station = Station.new
      second_train = double :train, is_a?: Train, initial_station: second_station
      station.receive_train(train)
      station.receive_train(second_train)
      station.release_train(train, second_train)
      expect(station.train_count).to eq(1)
    end

    it "should not release a train which isn't there" do
      expect(lambda {station.release_train(train)} ).to raise_error(RuntimeError)
    end

  end

end
