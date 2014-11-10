require 'carriage'

describe Carriage do

  let (:carriage) { Carriage.new(train: train) }
  let (:station) { double :station }
  let (:train) { double :train, current_station: station }

  it "should have a passenger capacity of 40" do
    expect(carriage.passenger_capacity).to eq(40)
  end

  it "should have the same current station as its train" do
    expect(carriage.current_station).to eq(train.current_station)
  end

end
