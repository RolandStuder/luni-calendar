class Luni::ListView
  attr_reader :events

  def initialize(events)
    @events = events.map do |event|
      raise NoMethodError unless event.respond_to?(:to_calendar_event)
      event.to_calendar_event
    end
  end
end
