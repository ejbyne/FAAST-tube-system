require 'train'

describe Train do

  before {
    allow(station).to receive(:receive_train)
  }

  let (:train) { Train.new(initial_station: station) }
  let (:station) { double :station }
  let (:second_station) { double :station, full_of_trains?: false }

  context "initial station" do

    it "allows an initial station to be set" do
      expect(train.current_station).to be(station)
    end

  end

  context "its carriages" do

    it "is initiated without any carriages" do
      expect(train.carriage_count).to eq(0)
    end

  end

  context "moving stations" do

    it "can move from one station to another" do
      allow(station).to receive(:release_train).with(train)
      allow(second_station).to receive(:receive_train).with(train)
      train.move(station, second_station)
      expect(train.current_station).to be(second_station)
    end

  end

end
