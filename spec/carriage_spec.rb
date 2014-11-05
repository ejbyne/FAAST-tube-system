require 'carriage'

describe Carriage do

  context "passenger capacity" do

    it "should have a passenger capacity of 40" do
      station = double :station
      train = double :train
      carriage = Carriage.new(train: train)
      expect(carriage.passenger_capacity).to eq(40)
    end

  end

end
