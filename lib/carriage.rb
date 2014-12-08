require_relative 'passenger_container'

class Carriage

  include PassengerContainer

  attr_reader :train

  def initialize(options = {})
    raise "Please specify train" if options[:train].nil?
    @train = options.fetch(:train)
    @train.carriages << self
  end

  def current_station
    @train.current_station
  end

  def accept_board(passenger)
    raise "Cannot board" unless passenger.current_station == current_station
    current_station.release_passenger(passenger)
    receive_passenger(passenger)
  end

  def accept_alight(passenger)
    current_station.receive_passenger(passenger)
    release_passenger(passenger)
  end

end