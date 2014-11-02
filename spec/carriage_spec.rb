require 'carriage'

describe Carriage do

  it "should have a passenger capacity of 40" do
    carriage = Carriage.new
    expect(carriage.passenger_capacity).to eq(40)
  end

end