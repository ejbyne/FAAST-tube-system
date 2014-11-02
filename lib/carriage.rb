require_relative 'passenger_container'

class Carriage

  include PassengerContainer

  def initialize(options = {})
    raise "Please specify train" if options[:train].nil?
    @train = options.fetch(:train)
  end

  def train
    @train
  end

end