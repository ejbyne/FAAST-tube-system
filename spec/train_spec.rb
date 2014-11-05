require 'train'

describe Train do

  let (:station) { double :station }
  let (:second_station) { double :station, full_of_trains?: false }

  context "initial station" do

    it "allows an initial station to be set" do
      expect(station).to receive(:receive_train)
      train = Train.new(initial_station: station)
    end

  end

  context "carriages" do

    it "has a default number of carriages" do
      allow(station).to receive(:receive_train)
      train = Train.new(initial_station: station)
      expect(train.set_carriage_count).to eq(5)
    end

    it "allows the number of carriages to be set on initializing" do
      allow(station).to receive(:receive_train)
      train = Train.new(initial_station: station, carriage_count: 7)
      expect(train.set_carriage_count).to eq(7)
    end

    it 'can hold carriages' do
      allow(station).to receive(:receive_train)
      train = Train.new(initial_station: station, carriage_count: 7)
      expect(train.carriage_count).to eq(7)
    end

  end

  context "moving stations" do

    it "can move from one station to another" do
      allow(station).to receive(:receive_train)
      train = Train.new(initial_station: station)
      allow(station).to receive(:release_train).with(train)
      allow(second_station).to receive(:receive_train).with(train)
      train.move(station, second_station)
      expect(train.current_station).to be(second_station)
    end

  end

end
