# frozen_string_literal: true

require "test_helper"

require "minitest/spec"

describe Luni::ListView do
  it "raises an error if an event does not respond to to_calendar_event" do
    events = [Luni::NonEventableExample.new]
    assert_raises(NoMethodError) do
      Luni::ListView.new(events)
    end
  end

  it "does not raise an error when all events respond to to_calendar_event" do
    events = [Luni::EventableExample.new]
    assert_silent do
      Luni::ListView.new(events)
    end
  end
end
