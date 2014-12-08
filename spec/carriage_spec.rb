require 'carriage'

describe Carriage do

  # before { allow (train.carriages).to receive(:push) }
  let (:carriage) { Carriage.new(train: train) }
  let (:station) { double :station }
  let (:train) { double :train, current_station: station, carriages: [] }
  let (:passenger) { double :passenger, current_station: station, credit: 10 }
  let (:passenger_outside_station) { double :passenger, current_station: nil }

  it "should have a passenger capacity of 40" do
    expect(carriage.passenger_capacity).to eq(40)
  end

  it "should have the same current station as its train" do
    expect(carriage.current_station).to eq(train.current_station)
  end

  it "should be added to its train's carriages" do
    expect(train.carriages).to include(carriage)
  end

  it "should allow a passenger to board" do
    allow(station).to receive(:release_passenger)
    carriage.accept_board(passenger)
    expect(carriage.passenger_count).to eq(1)
  end

  it "should allow a passenger to alight" do
    allow(station).to receive(:release_passenger)
    carriage.accept_board(passenger)
    allow(station).to receive(:receive_passenger)
    carriage.accept_alight(passenger)
    expect(carriage.passenger_count).to eq(0)
  end

  it "should not be able to board a carriage before it touches in at the station" do
    
    expect(lambda { carriage.accept_board(passenger) }).to raise_error("Cannot board")
  end

end
