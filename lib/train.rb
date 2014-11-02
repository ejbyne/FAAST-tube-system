class Train

DEFAULT_INITIAL_STATION = :depot #this class instance needs to be set up?
DEFAULT_CARRIAGE_CAPACITY = 5

  def initialize(options = {})
    @current_station = options.fetch(:initial_station, DEFAULT_INITIAL_STATION)
    @carriage_capacity = options.fetch(:carriage_capacity, DEFAULT_CARRIAGE_CAPACITY)
    @carriages = []
    #@current_station.receive_train(self)
  end

  def current_station
    @current_station
  end

  def carriage_capacity
    @carriage_capacity
  end

  def carriages
    @carriages
  end

  def carriage_count
    carriages.count
  end

  def full_of_carriages?
    carriage_count == carriage_capacity
  end

  def move(start_station, end_station)
    raise "Destination station is full" if end_station.full_of_trains?
    start_station.release_train(self)
    end_station.receive_train(self)
    @current_station = end_station
  end

  def add_carriage(*carriage)
    #raise "Cannot process request" unless carriage.first.is_a?(Carriage)
    raise "Maximum carriages reached" if full_of_carriages?
    carriages << carriage.first
  end

  def remove_carriage(*carriage)
    #raise "Cannot process request" unless carriage.first.is_a?(Carriage)
    carriages.delete(carriage.first)
  end

end