require_relative 'passenger_container'

class Station

  include PassengerContainer

  attr_reader :train_capacity, :trains

  DEFAULT_TRAIN_CAPACITY = 2

  def initialize(options = {})
    @train_capacity = options.fetch(:train_capacity, DEFAULT_TRAIN_CAPACITY)
    self.passenger_capacity = options.fetch(:passenger_capacity, DEFAULT_PASSENGER_CAPACITY)
    @trains = []
  end

  def train_count
    @trains.count
  end

  def full_of_trains?
    train_count == train_capacity
  end

  def receive_train(train)
    raise "Station full" if full_of_trains?
    @trains << train
  end

  def release_train(train)
    raise "Train not there" unless @trains.include?(train)
    @trains.delete(train)
  end

  def allow_touch_in(passenger)
    self.receive_passenger(passenger)
    passenger.current_station = self
  end

  def allow_touch_out(passenger)
    self.release_passenger(passenger)
    passenger.current_station = nil
  end

end