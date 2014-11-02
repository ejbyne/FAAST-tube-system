require 'carriage'

describe Carriage do

  it "should have a default passenger capacity if none is specified" do
    default_carriage = Carriage.new
    expect(default_carriage.passenger_capacity).to eq(50)
  end

  it "should allow setting passenger capacity on initializing" do
    carriage = Carriage.new(passenger_capacity: 40)
    expect(carriage.passenger_capacity).to eq(40)
  end

end