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

end