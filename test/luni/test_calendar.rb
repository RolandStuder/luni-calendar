# frozen_string_literal: true

require "test_helper"

class Luni::TestCalendar < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Luni::Calendar::VERSION
  end
end
