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

  def receive_train(train)
    @trains << train
  end

  def receive_passenger(passenger)
    @passengers << passenger
  end

  def release_train(train)
    @trains.delete(train)
  end

  def release_passenger(passenger)
    @passengers.delete(passenger)
  end


end