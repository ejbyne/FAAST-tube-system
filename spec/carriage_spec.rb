require 'carriage'

describe Carriage do

  it "should have a passenger capacity of 40" do
    station = Station.new
    train = Train.new(initial_station: station)
    carriage = Carriage.new(train: train)
    expect(carriage.passenger_capacity).to eq(40)
  end

end