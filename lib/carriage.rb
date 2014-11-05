require_relative 'passenger_container'

class Carriage

  include PassengerContainer

  attr_reader :train

  def initialize(options = {})
    raise "Please specify train" if options[:train].nil?
    @train = options.fetch(:train)
  end

end