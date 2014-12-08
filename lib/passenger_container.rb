module PassengerContainer

  DEFAULT_PASSENGER_CAPACITY = 40

  def passengers
    @passengers ||= []
  end

  def passenger_capacity
    @passenger_capacity ||= DEFAULT_PASSENGER_CAPACITY
  end

  def passenger_capacity=(value)
    @passenger_capacity = value
  end

  def passenger_count
    passengers.count
  end

  def full_of_passengers?
    passenger_count == passenger_capacity
  end

  def receive_passenger(passenger)
    raise "Cannot enter" if full_of_passengers? || passenger.credit < 2
    passengers << passenger
  end

  def release_passenger(passenger)
    passengers.delete(passenger)
  end

end