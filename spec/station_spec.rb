require 'station'

describe Station do

  let (:station) { Station.new(train_capacity: 6, passenger_capacity: 300) }
  let (:station2) { Station.new }
  let (:train) { double :train, is_a?: Train }

  def fill_station_with_trains
    6.times { station.receive_train(train) }
  end

  it "should have default train and passenger capacities if none are specified" do
    default_station = Station.new
    expect(default_station.train_capacity).to eq(2)
    expect(default_station.passenger_capacity).to eq(40)
  end

  it "should allow setting train and passenger capacities on initializing" do
    expect(station.train_capacity).to eq(6)
    expect(station.passenger_capacity).to eq(300)
  end

  it "should be able to receive a train" do
    expect(station.train_count).to eq(0)
    station.receive_train(train)
    expect(station.train_count).to eq(1)
  end

  it "should be able to release a train" do
    station.receive_train(train)
    station.release_train(train)
    expect(station.train_count).to eq(0)
  end

  it "should know when it's full of trains" do
    expect(station).not_to be_full_of_trains
    fill_station_with_trains
    expect(station).to be_full_of_trains
  end

  it "cannot receive more than trains than its capacity" do
    fill_station_with_trains
    expect(lambda { station.receive_train(train)} ).to raise_error(RuntimeError)
  end

  it "should only receive tube trains with receive_train" do
    expect(lambda { station.receive_train(:not_a_train) }).to raise_error(RuntimeError)
  end

  it "should raise an error if empty argument is passed to receive_train" do
    expect(lambda {station.receive_train()} ).to raise_error(RuntimeError)
  end

  it "should only accept one train at at time" do
    station.receive_train(train, train)
    expect(station.train_count).to eq(1)
  end

  it "should only release one train at a time" do
    second_train = Train.new(initial_station: station2)
    station.receive_train(train)
    station.receive_train(second_train)
    station.release_train(train, second_train)
    expect(station.train_count).to eq(1)
  end

  it "should not release a train which isn't there" do
    expect(lambda {station.release_train(train)} ).to raise_error(RuntimeError)
  end

end

# TESTS WITHOUT DOUBLES
# describe Station do

#   let (:station) { Station.new(train_capacity: 6, passenger_capacity: 300) }
#   let (:station2) { Station.new }
#   let (:train) { Train.new(initial_station: station2) }

#   def fill_station_with_trains
#     6.times { station.receive_train(train) }
#   end

#   it "should have default train and passenger capacities if none are specified" do
#     default_station = Station.new
#     expect(default_station.train_capacity).to eq(2)
#     expect(default_station.passenger_capacity).to eq(40)
#   end

#   it "should allow setting train and passenger capacities on initializing" do
#     expect(station.train_capacity).to eq(6)
#     expect(station.passenger_capacity).to eq(300)
#   end

#   it "should be able to receive a train" do
#     expect(station.train_count).to eq(0)
#     station.receive_train(train)
#     expect(station.train_count).to eq(1)
#   end

#   it "should be able to release a train" do
#     station.receive_train(train)
#     station.release_train(train)
#     expect(station.train_count).to eq(0)
#   end

#   it "should know when it's full of trains" do
#     expect(station).not_to be_full_of_trains
#     fill_station_with_trains
#     expect(station).to be_full_of_trains
#   end

#   it "cannot receive more than trains than its capacity" do
#     fill_station_with_trains
#     expect(lambda { station.receive_train(train)} ).to raise_error(RuntimeError)
#   end

#   it "should only receive tube trains with receive_train" do
#     expect(lambda { station.receive_train(:not_a_train) }).to raise_error(RuntimeError)
#   end

#   it "should raise an error if empty argument is passed to receive_train" do
#     expect(lambda {station.receive_train()} ).to raise_error(RuntimeError)
#   end

#   it "should only accept one train at at time" do
#     station.receive_train(train, train)
#     expect(station.train_count).to eq(1)
#   end

#   it "should only release one train at a time" do
#     second_train = Train.new(initial_station: station2)
#     station.receive_train(train)
#     station.receive_train(second_train)
#     station.release_train(train, second_train)
#     expect(station.train_count).to eq(1)
#   end

#   it "should not release a train which isn't there" do
#     expect(lambda {station.release_train(train)} ).to raise_error(RuntimeError)
#   end

# end