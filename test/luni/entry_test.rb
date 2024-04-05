# frozen_string_literal: true

require "test_helper"

require "minitest/spec"

describe Luni::Event do
  it "has accessible attributes on entry instances" do
    attributes = {name: "Test Event", model: "TestModel"}
    entry = Luni::Event.new(starts_at: Time.now, ends_at: Time.now + 1, attributes: attributes)

    assert_equal "Test Event", entry.name
    assert_equal "TestModel", entry.model
  end
end
