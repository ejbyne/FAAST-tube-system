class Station

  DEFAULT_TRAIN_CAPACITY = 2
  DEFAULT_PASSENGER_CAPACITY = 200

  def initialize(capacities = {})
    @train_capacity = capacities.fetch(:train_capacity, DEFAULT_TRAIN_CAPACITY)
    @passenger_capacity = capacities.fetch(:passenger_capacity, DEFAULT_PASSENGER_CAPACITY)
    @trains = []
    @passengers = []
  end

  def train_capacity
    @train_capacity
  end

  def passenger_capacity
    @passenger_capacity
  end

  def train_count
    @trains.count
  end

  def passenger_count
    @passengers.count
  end

  def full_of_passengers?
    passenger_count == passenger_capacity
  end

  def full_of_trains?
    train_count == train_capacity
  end

  def receive_train(*train)
    #raise "Cannot process request" unless train.first.is_a?(Train)
    raise "Station full" if full_of_trains?
    @trains << train.first
  end

  def receive_passenger(*passenger)
    #raise "Cannot process request" unless passenger.first.is_a?(Passenger)
    raise "Station full" if full_of_passengers?
    @passengers << passenger.first
  end

  def release_train(*train)
    @trains.delete(train.first)
  end

  def release_passenger(*passenger)
    @passengers.delete(passenger.first)
  end


end