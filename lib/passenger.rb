class Passenger

  DEFAULT_CREDIT = 10

  def initialize(options = {})
    @credit = options.fetch(:credit, DEFAULT_CREDIT)
  end

  def credit
    @credit
  end

  def current_station
    @current_station ||= nil
  end

  def current_station=(station)
    @current_station = station
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
    self.touch_out(current_station)
    carriage.receive_passenger(self)
  end

end