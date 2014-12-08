require 'passenger_container'

class ContainerHolder; include PassengerContainer; end

describe PassengerContainer do

  let (:holder) { ContainerHolder.new }
  let (:passenger) { double :passenger, has_insufficient_credit?: false }
  let (:passenger_with_low_credit) { double :passenger, has_insufficient_credit?: true }

  def fill_holder_with_passengers
    40.times { holder.receive_passenger(passenger) }
  end

  context "capacity" do

    it "should have a default passenger capacity" do
      expect(holder.passenger_capacity).to eq(40)
    end

    it "should allow the passenger capacity to be set" do
      holder.passenger_capacity = 50
      expect(holder.passenger_capacity).to eq(50)
    end

  end

  context "receiving passengers" do

    it "should be created empty" do
      expect(holder.passenger_count).to eq(0)
    end

    it "should be able to receive a passenger" do
      holder.receive_passenger(passenger)
      expect(holder.passenger_count).to eq(1)
    end

    it "should know when it's full of passengers" do
      fill_holder_with_passengers
      expect(holder).to be_full_of_passengers
    end

    it "cannot receive more passengers than its capacity" do
      fill_holder_with_passengers
      expect(lambda { holder.receive_passenger(passenger) }).to raise_error("Cannot enter")
    end

    it "should not receive a passenger if he/she does not have at least GBP 2 credit" do
      expect( lambda { holder.receive_passenger(passenger_with_low_credit) }).to raise_error("Cannot enter")
    end

  end

  context "releasing passengers" do

    it "should be able to release a passenger" do
      holder.receive_passenger(passenger)
      holder.release_passenger(passenger)
      expect(holder.passenger_count).to eq(0)
    end

  end

end
