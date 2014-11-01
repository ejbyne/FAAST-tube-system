require 'station'

describe Station do

  let (:station) { Station.new(train_capacity: 6, passenger_capacity: 300) }
  let (:train) { double :train }
  let (:passenger) { double :passenger }

  def fill_station_with_passengers
    300.times { station.receive_passenger(passenger) }
  end

  def fill_station_with_trains
    6.times { station.receive_train(train) }
  end

  it "should have default capacities if none are specified" do
    default_station = Station.new
    expect(default_station.train_capacity).to eq(2)
    expect(default_station.passenger_capacity).to eq(200)
  end

  it "should allow setting initial capacities on initializing" do
    expect(station.train_capacity).to eq(6)
    expect(station.passenger_capacity).to eq(300)
  end

  it "should be able to receive a train" do
    expect(station.train_count).to eq(0)
    station.receive_train(train)
    expect(station.train_count).to eq(1)
  end

  it "should be able to accept a person" do
    expect(station.passenger_count).to eq(0)
    station.receive_passenger(passenger)
    expect(station.passenger_count).to eq(1)
  end

  it "should be able to release a train" do
    station.receive_train(train)
    station.release_train(train)
    expect(station.train_count).to eq(0)
  end

  it "should be able to release a passenger" do
    station.receive_passenger(passenger)
    station.release_passenger(passenger)
    expect(station.passenger_count).to eq(0)
  end

  it "should know when it's full of passengers" do
    expect(station).not_to be_full_of_passengers
    fill_station_with_passengers
    expect(station).to be_full_of_passengers
  end

  it "should know when it's full of trains" do
    expect(station).not_to be_full_of_trains
    fill_station_with_trains
    expect(station).to be_full_of_trains
  end

  it "cannot receive more passengers than its capacity" do
    fill_station_with_passengers
    expect(lambda { station.receive_passenger(passenger) }).to raise_error(RuntimeError)
  end

  it "cannot receive more than trains than its capacity" do
    fill_station_with_trains
    expect(lambda { station.receive_train(train)} ).to raise_error(RuntimeError)
  end

  # it "should only receive tube trains with receive_train" do
  #   expect(lambda { station.receive_train(:not_a_train) }).to raise_error(RuntimeError)
  # end

  # it "should only receive passengers with receive_passenger" do
  #   expect(lambda { station.receive_passenger(:not_a_passenger)} ).to raise_error(RuntimeError)
  # end

  # it "should raise an error if empty argument is passed to receive_passenger" do
  #   expect(lambda { station.receive_passenger() } ).to raise_error(RuntimeError)
  # end

  # it "should raise an error if empty argument is passed to receive_train" do
  #   expect(lambda {station.receive_train()} ).to raise_error(RuntimeError)
  # end

  it "should only accept one passenger at a time" do
    station.receive_passenger(passenger, passenger)
    expect(station.passenger_count).to eq(1)
  end

  it "should only accept one train at at time" do
    station.receive_train(train, train)
    expect(station.train_count).to eq(1)
  end

  it "should only release one passenger at a time" do
    second_passenger = double :passenger
    station.receive_passenger(passenger)
    station.receive_passenger(second_passenger)
    station.release_passenger(passenger, second_passenger)
    expect(station.passenger_count).to eq(1)
  end

  it "should only release one train at a time" do
    second_train = double :train
    station.receive_train(train)
    station.receive_train(second_train)
    station.release_train(train, second_train)
    expect(station.train_count).to eq(1)
  end

  # it "should not release a passenger who isn't there" do
  #   expect(lambda {station.release_passenger(passenger)} ).to raise_error(RuntimeError)
  # end

  # it "should not release a train which isn't there" do
  #   expect(lambda {station.release_train(train)} ).to raise_error(RuntimeError)
  # end

  it "should only receive passengers with an account and a minimum credit of £2"


  
end