require 'train'

describe Train do

  let (:station) { double :station }
  let (:station2) { double :station, full_of_trains?: false }

  it "allows an initial station to be set" do
    expect(station).to receive(:receive_train)
    train = Train.new(initial_station: station)
  end

  it "has a default carriage count" do
    allow(station).to receive(:receive_train)
    train = Train.new(initial_station: station)
    expect(train.carriage_count).to eq(5)
  end

  it "allows a carriage count to be set on initializing" do
    allow(station).to receive(:receive_train)
    train = Train.new(initial_station: station, carriage_count: 7)
    expect(train.carriage_count).to eq(7)
  end

  it 'can hold carriages' do
    allow(station).to receive(:receive_train)
    train = Train.new(initial_station: station, carriage_count: 7)
    expect(train.carriages.count).to eq(7)
  end

  it "can move from one station to another" do
    allow(station).to receive(:receive_train)
    train = Train.new(initial_station: station)
    allow(station).to receive(:release_train).with(train)
    allow(station2).to receive(:receive_train).with(train)
    train.move(station, station2)
    expect(train.current_station).to be(station2)
  end

end

# TESTS WITHOUT DOUBLES:
# describe Train do
  
#   let (:train) { Train.new(initial_station: station, carriage_count: 7) }
#   let (:default_train) { default_train = Train.new(initial_station: station) }
#   let (:station) { Station.new }
#   let (:old_street) { double :station }
#   let (:bank) { double :station }

#   it "allows an initial station to be set" do
#     expect(train.current_station).to be(station)
#   end

#   it "has a default carriage count" do
#     expect(default_train.carriage_count).to eq(5)
#   end

#   it "allows a carriage count to be set on initializing" do
#     expect(train.carriage_count).to eq(7)
#   end

#   it "can move from one station to another" do
#     allow(bank).to receive(:full_of_trains?).and_return(false)
#     expect(old_street).to receive(:release_train).with(train)
#     expect(bank).to receive(:receive_train).with(train)
#     train.move(old_street, bank)
#     expect(train.current_station).to be(bank)
#   end

# end