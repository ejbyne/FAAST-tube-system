class Passenger

  DEFAULT_CREDIT = 10

  attr_reader :credit, :current_station

  def initialize(options = {})
    @credit = options.fetch(:credit, DEFAULT_CREDIT)
    @current_station ||= nil
  end

  def touch_in(station)
    station.receive_passenger(self)
    @current_station = station
  end

  def touch_out(station)
    station.release_passenger(self)
    @current_station = nil
  end

  def board(carriage)
    raise "Cannot board" unless current_station == carriage.train.current_station
    touch_out(current_station)
    carriage.receive_passenger(self)
    @current_station = nil
  end

  def alight(carriage)
    carriage.release_passenger(self)
    carriage.train.current_station.receive_passenger(self)
    @current_station = carriage.train.current_station
  end

end