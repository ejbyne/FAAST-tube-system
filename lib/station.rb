require_relative 'passenger_container'

class Station

  include PassengerContainer

  DEFAULT_TRAIN_CAPACITY = 2

  def initialize(options = {})
    @train_capacity = options.fetch(:train_capacity, DEFAULT_TRAIN_CAPACITY)
    self.passenger_capacity = options.fetch(:passenger_capacity, DEFAULT_PASSENGER_CAPACITY)
    @trains = []
  end

  def train_capacity
    @train_capacity
  end

  def train_count
    @trains.count
  end

  def full_of_trains?
    train_count == train_capacity
  end

  def receive_train(*train)
    raise "Cannot process request" unless train.first.is_a?(Train)
    raise "Station full" if full_of_trains?
    @trains << train.first
  end

  def release_train(*train)
    raise "Train not there" unless @trains.include?(train.first)
    @trains.delete(train.first)
  end

end