require 'passenger'

describe Passenger do
  
  let (:passenger) { Passenger.new }
  let (:station) { double :station }
  let (:station2) { double :station }
  let (:passenger_with_low_credit) { Passenger.new(credit: 1) }
  let (:train) { double :train }
  let (:train2) { double :train }
  let (:carriage) { double :carriage }

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

  # it "should not be able to touch in at a station if he/she does not have at least GBP 2 credit" do
  #   expect( lambda { passenger_with_low_credit.touch_in(test_station) }).to raise_error(RuntimeError)
  # end

  # it "should be able to board a carriage of a train which is at the same station as the passenger" do
  #   expect(station).to receive(:release_passenger).with(passenger)
  #   passenger.touch_in(station)
    # passenger.board(train.carriages.first)
    # expect(passenger.current_station).to be(nil)
    # expect(test_station.passenger_count).to eq(0)
    # expect(train.carriages.first.passenger_count).to eq(1)
  # end

  it "should be able to alight a carriage of a train which is at a station" do
    # passenger.touch_in(station)
    # passenger.board(carriage)
    # train.move(test_station, test_station2)
    allow(carriage).to receive(:release_passenger).with(passenger)
    allow(carriage).to receive(:train)
    allow(nil).to receive(:current_station)
    allow(nil).to receive(:receive_passenger).with(passenger)
    passenger.alight(carriage)
    # expect(train.carriages.first.passenger_count).to eq(0)
    # expect(test_station2.passenger_count).to eq(1)
  end

  # it "should not be able to board a carriage of a train which is not at the same station" do
  #   passenger.touch_in(test_station)
  #   expect(passenger.current_station).to be(test_station)
  #   expect(lambda { passenger.board(train2.carriages.first) }).to raise_error(RuntimeError)
  #   expect(test_station.passenger_count).to eq(1)
  #   expect(train2.carriages.first.passenger_count).to eq(0)
  # end

  # it "should not be able to board a carriage if the carriage is full of passengers" do
  #   fill_station
  #   test_station.passengers[0...40].each { |passenger| passenger.board(train.carriages.first) }
  #   expect(lambda { test_station.passengers.first.board(train.carriages.first) }).to raise_error(RuntimeError)
  # end

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