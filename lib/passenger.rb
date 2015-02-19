class Passenger

  DEFAULT_CREDIT = 10

  attr_reader :credit, :current_station

  def initialize(options = {})
    @credit = options.fetch(:credit, DEFAULT_CREDIT)
    @current_station ||= nil
  end

  def current_station=(station)
    @current_station = station
  end

  def has_insufficient_credit?
    @credit < 2
  end

end