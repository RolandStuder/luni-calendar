module Luni
  class EventableExample
    def name
      "Bob"
    end

    def to_calendar_event
      Luni::Event.new(starts_at: Time.now, ends_at: Time.now + 1, attributes: {name: name, model: self})
    end
  end

  class NonEventableExample
    # This class intentionally does not implement to_calendar_event
  end
end
