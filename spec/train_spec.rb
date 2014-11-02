require 'train'

describe Train do
  
  let (:train) { Train.new(initial_station: station, carriage_count: 7) }
  let (:default_train) { default_train = Train.new(initial_station: station) }
  let (:station) { Station.new }
  let (:old_street) { double :station }
  let (:bank) { double :station }
  #let (:depot) { double :station }
  # let (:carriage) {double :carriage }

  it "allows an initial station to be set" do
    expect(train.current_station).to be(station) #need class instance?
    #expect(train.current_station).to receive(receive_train).with(train)
  end

  it "has a default carriage count" do
    expect(default_train.carriage_count).to eq(5)
  end

  it "allows a carriage count to be set on initializing" do
    expect(train.carriage_count).to eq(7)
  end

  it "can move from one station to another" do
    allow(bank).to receive(:full_of_trains?).and_return(false)
    expect(old_street).to receive(:release_train).with(train)
    expect(bank).to receive(:receive_train).with(train)
    train.move(old_street, bank)
    expect(train.current_station).to be(bank)
  end

  # it "has a default initial station" do
  #   expect(default_train.current_station).to be(:depot) #need class instance?
  #   #expect(default_train.current_station).to receive(receive_train).with(default_train)
  # end

  # it "has a default carriage capacity" do
  #   expect(default_train.carriage_capacity).to be(5)
  # end

  # it "allows a carriage capacity to be set" do
  #   expect(train.carriage_capacity).to be(7)
  # end

  # it "can add carriages" do
  #   expect(train.carriage_count).to be(0)
  #   train.add_carriage(carriage)
  #   expect(train.carriage_count).to be(1)
  # end

  # it "can remove carriages" do
  #   train.add_carriage(carriage)
  #   train.remove_carriage(carriage)
  #   expect(train.carriage_count).to be(0)
  # end

end