require 'station'

describe Station do

  let (:station) { Station.new(train_capacity: 6, passenger_capacity: 300) }
  let (:train) { double :train }
  let (:passenger) { double :passenger }

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
    station.release_passenger (passenger)
    expect(station.passenger_count).to eq(0)
  end

  it "should know when it's full"

  it "cannot receive more passengers than its capacity"

  it "cannot receive more than trains than its capacity"

  it "should only receive trains of the correct class"

  it "should only accept one passenger or train at a time"

  it "should only receive passengers with an account and a minimum credit of £2"


  
end