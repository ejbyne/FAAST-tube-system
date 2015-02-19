require_relative 'passenger_container'

class Carriage

  include PassengerContainer

  attr_reader :train

  def initialize()
    @train = nil
  end

  def couple_to(train)
    @train = train
    @train.carriages << self
  end

  def current_station
    raise "No current station" if train == nil
    @current_station = @train.current_station
  end

  def accept_board(passenger)
    raise "Cannot board" unless passenger.current_station == current_station
    current_station.release_passenger(passenger)
    receive_passenger(passenger)
    passenger.current_station = nil
  end

  def accept_alight(passenger)
    current_station.receive_passenger(passenger)
    release_passenger(passenger)
    passenger.current_station = current_station
  end

end