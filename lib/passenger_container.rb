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

  def receive_passenger(*passenger)
    raise "Cannot process request" unless passenger.first.is_a?(Passenger)
    raise "Cannot enter" if full_of_passengers? || passenger.first.credit < 2
    passengers << passenger.first
  end

  def release_passenger(*passenger)
    raise "Passenger not there" unless passengers.include?(passenger.first)
    passengers.delete(passenger.first)
  end

end