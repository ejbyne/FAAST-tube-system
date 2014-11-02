require 'passenger_container'

class ContainerHolder; include PassengerContainer; end

describe PassengerContainer do

  let (:holder) { ContainerHolder.new }
  #let (:passenger) { double :passenger }
  let (:passenger) { Passenger.new }
  let (:station) { Station.new }

  def fill_holder_with_passengers
    40.times { holder.receive_passenger(passenger) }
  end

  it "should be able to receive a person" do
    expect(holder.passenger_count).to eq(0)
    holder.receive_passenger(passenger)
    expect(holder.passenger_count).to eq(1)
  end

  it "should be able to release a passenger" do
    holder.receive_passenger(passenger)
    holder.release_passenger(passenger)
    expect(holder.passenger_count).to eq(0)
  end

  it "should know when it's full of passengers" do
    expect(holder).not_to be_full_of_passengers
    fill_holder_with_passengers
    expect(holder).to be_full_of_passengers
  end

  it "cannot receive more passengers than its capacity" do
    fill_holder_with_passengers
    expect(lambda { holder.receive_passenger(passenger) }).to raise_error(RuntimeError)
  end

  # it "should only receive passengers with receive_passenger" do
  #   expect(lambda { holder.receive_passenger(:not_a_passenger)} ).to raise_error(RuntimeError)
  # end

  # it "should raise an error if empty argument is passed to receive_passenger" do
  #   expect(lambda { holder.receive_passenger() } ).to raise_error(RuntimeError)
  # end

  it "should only accept one passenger at a time" do
    holder.receive_passenger(passenger, passenger)
    expect(holder.passenger_count).to eq(1)
  end

  it "should only release one passenger at a time" do
    #second_passenger = double :passenger
    second_passenger = Passenger.new
    holder.receive_passenger(passenger)
    holder.receive_passenger(second_passenger)
    holder.release_passenger(passenger, second_passenger)
    expect(holder.passenger_count).to eq(1)
  end

  # it "should not release a passenger who isn't there" do
  #   expect(lambda {holder.release_passenger(passenger)} ).to raise_error(RuntimeError)
  # end

end