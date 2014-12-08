class Passenger

  DEFAULT_CREDIT = 10

  attr_reader :credit
  attr_writer :current_station

  def initialize(options = {})
    @credit = options.fetch(:credit, DEFAULT_CREDIT)
    @current_station ||= nil
  end

  def current_station
    @current_station
  end

  def has_insufficient_credit?
    @credit < 2
  end

end