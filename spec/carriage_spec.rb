require 'carriage'

describe Carriage do

  before { allow(train.carriages).to receive(:push) }
  let (:carriage) { Carriage.new(train: train) }
  let (:station) { double :station }
  let (:train) { double :train, current_station: station, carriages: [] }

  it "should have a passenger capacity of 40" do
    expect(carriage.passenger_capacity).to eq(40)
  end

  it "should have the same current station as its train" do
    expect(carriage.current_station).to eq(train.current_station)
  end

  it "should be added to its train's carriages" do
    expect(train.carriages).to include(carriage)
  end

end
