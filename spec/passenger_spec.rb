require 'passenger'

describe Passenger do
  
  let (:passenger) { Passenger.new }
  let (:station) { double :station }
  let (:test_station) { Station.new }
  let (:test_station2) { Station.new }
  let (:passenger_with_low_credit) { Passenger.new(credit: 1) }
  let (:train) { Train.new(initial_station: test_station) }
  let (:train2) { Train.new(initial_station: test_station2) }
  # let (:test_carriage) { Carriage.new(train: train) }


  it "should be able to touch in at a station" do
    expect(station).to receive(:receive_passenger).with(passenger)
    passenger.touch_in(station)
  end

  it "should be able to touch out at a station" do
    expect(station).to receive(:release_passenger).with(passenger)
    passenger.touch_out(station)
  end

  it "should not be able to touch in at a station if the station is full of passengers" do
    40.times { passenger.touch_in(test_station) }
    expect(test_station.passenger_count).to eq(40)
    expect(lambda { passenger.touch_in(test_station) }).to raise_error(RuntimeError)
  end

  it "should not be able to touch in at a station if he/she does not have at least GBP 2 credit" do
    expect( lambda { passenger_with_low_credit.touch_in(test_station) }).to raise_error(RuntimeError)
  end

  it "should be able to board a carriage of a train which is at the same station as the passenger" do
    passenger.touch_in(test_station)
    passenger.board(train.carriages.first)
    expect(passenger.current_station).to be(nil)
    expect(test_station.passenger_count).to eq(0)
    expect(train.carriages.first.passenger_count).to eq(1)
  end

  it "should be able to alight a carriage of a train which is at a station"

  it "should not be able to board a carriage of a train which is not at the same station" do
    passenger.touch_in(test_station)
    # test_station2.receive_train(train)
    expect(passenger.current_station).to be(test_station)
    expect(lambda { passenger.board(train2.carriages.first) }).to raise_error(RuntimeError)
    # expect(test_station.passenger_count).to eq(1)
    # expect(train.carriages.first.passenger_count).to eq(0)
  end

  it "should not be able to board a carriage if the carriage is full of passengers"

  it "should not be able to board a carriage if he/she does not have at least GBP 2 credit"

end