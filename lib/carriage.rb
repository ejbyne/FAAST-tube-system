require_relative 'passenger_container'

class Carriage

  include PassengerContainer

  def initialize(options = {})
    self.passenger_capacity = options.fetch(:passenger_capacity, DEFAULT_PASSENGER_CAPACITY)
  end

end