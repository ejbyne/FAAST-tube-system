class Train

attr_reader :current_station, :set_carriage_count, :carriages, :carriage_count

DEFAULT_CARRIAGE_COUNT = 5

  def initialize(options = {})
    raise "Please specify initial station" if options[:initial_station].nil?
    @current_station = options.fetch(:initial_station)
    @set_carriage_count = options.fetch(:carriage_count, DEFAULT_CARRIAGE_COUNT)
    @current_station.receive_train(self)
    add_carriages 
  end

  def add_carriages
    @carriages = []
    @set_carriage_count.times { @carriages << Carriage.new(train: self) }
    @carriage_count = @carriages.count
  end

  def move(start_station, end_station)
    raise "Destination station is full" if end_station.full_of_trains?
    start_station.release_train(self)
    end_station.receive_train(self)
    @current_station = end_station
  end

end