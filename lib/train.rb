class Train

DEFAULT_CARRIAGE_COUNT = 5

  def initialize(options = {})
    raise "Please specify initial station" if options[:initial_station].nil?
    @current_station = options.fetch(:initial_station)
    @set_carriage_count = options.fetch(:carriage_count, DEFAULT_CARRIAGE_COUNT)
    @carriages = []
    @set_carriage_count.times { @carriages << Carriage.new(train: self) }
    @current_station.receive_train(self)
  end

  def current_station
    @current_station
  end

  def set_carriage_count
    @set_carriage_count
  end

   def carriages
    @carriages
  end

  def carriage_count
    @carriages.count
  end

  def move(start_station, end_station)
    raise "Destination station is full" if end_station.full_of_trains?
    start_station.release_train(self)
    end_station.receive_train(self)
    @current_station = end_station
  end

end