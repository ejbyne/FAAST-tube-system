class Train

attr_reader :current_station, :carriages, :carriage_count

  def initialize(options = {})
    raise "Please specify initial station" if options[:initial_station].nil?
    @current_station = options.fetch(:initial_station)
    @current_station.receive_train(self)
    @carriages = []
    @carriage_count = @carriages.count
  end

  def move(start_station, end_station)
    raise "Destination station is full" if end_station.full_of_trains?
    start_station.release_train(self)
    end_station.receive_train(self)
    @current_station = end_station
  end

end