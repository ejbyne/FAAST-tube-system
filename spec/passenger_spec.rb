require 'passenger'

describe Passenger do
  
  let (:passenger) { Passenger.new }
  let (:passenger_with_low_credit) { Passenger.new(credit: 1) }
  let (:station) { double :station }
  let (:station2) { double :station }
  let (:train) { double :train, current_station: station }
  let (:train2) { double :train, current_station: station2 }
  let (:carriage) { double :carriage, train: train }
  let (:carriage2) { double :carriage, train: train2 }

  def fill_station
    41.times { passenger.touch_in(station) }
  end

  it "should be able to touch in at a station" do
    expect(station).to receive(:receive_passenger).with(passenger)
    passenger.touch_in(station)
  end

  it "should be able to touch out at a station" do
    expect(station).to receive(:release_passenger).with(passenger)
    passenger.touch_out(station)
  end

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

  it "should not be able to board a carriage of a train which is not at the same station" do
    allow(station).to receive(:receive_passenger).with(passenger)
    passenger.touch_in(station)
    expect(lambda { passenger.board(carriage2) }).to raise_error(RuntimeError)
  end

end

# TESTS WITHOUT DOUBLES

# describe Passenger do
  
#   let (:passenger) { Passenger.new }
#   let (:station) { double :station }
#   let (:test_station) { Station.new(passenger_capacity: 41) }
#   let (:test_station2) { Station.new }
#   let (:passenger_with_low_credit) { Passenger.new(credit: 1) }
#   let (:train) { Train.new(initial_station: test_station) }
#   let (:train2) { Train.new(initial_station: test_station2) }

#   def fill_station
#     41.times { Passenger.new.touch_in(test_station) }
#   end

#   it "should be able to touch in at a station" do
#     expect(station).to receive(:receive_passenger).with(passenger)
#     passenger.touch_in(station)
#   end

#   it "should be able to touch out at a station" do
#     expect(station).to receive(:release_passenger).with(passenger)
#     passenger.touch_out(station)
#   end

#   it "should not be able to touch in at a station if the station is full of passengers" do
#     fill_station
#     expect(test_station.passenger_count).to eq(41)
#     expect(lambda { passenger.touch_in(test_station) }).to raise_error(RuntimeError)
#   end

#   it "should not be able to touch in at a station if he/she does not have at least GBP 2 credit" do
#     expect( lambda { passenger_with_low_credit.touch_in(test_station) }).to raise_error(RuntimeError)
#   end

#   it "should be able to board a carriage of a train which is at the same station as the passenger" do
#     passenger.touch_in(test_station)
#     passenger.board(train.carriages.first)
#     expect(passenger.current_station).to be(nil)
#     expect(test_station.passenger_count).to eq(0)
#     expect(train.carriages.first.passenger_count).to eq(1)
#   end

#   it "should be able to alight a carriage of a train which is at a station" do
#     passenger.touch_in(test_station)
#     passenger.board(train.carriages.first)
#     train.move(test_station, test_station2)
#     passenger.alight(train.carriages.first)
#     expect(train.carriages.first.passenger_count).to eq(0)
#     expect(test_station2.passenger_count).to eq(1)
#   end

#   it "should not be able to board a carriage of a train which is not at the same station" do
#     passenger.touch_in(test_station)
#     expect(passenger.current_station).to be(test_station)
#     expect(lambda { passenger.board(train2.carriages.first) }).to raise_error(RuntimeError)
#     expect(test_station.passenger_count).to eq(1)
#     expect(train2.carriages.first.passenger_count).to eq(0)
#   end

#   it "should not be able to board a carriage if the carriage is full of passengers" do
#     fill_station
#     test_station.passengers[0...40].each { |passenger| passenger.board(train.carriages.first) }
#     expect(lambda { test_station.passengers.first.board(train.carriages.first) }).to raise_error(RuntimeError)
#   end

# end