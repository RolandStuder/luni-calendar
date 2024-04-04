# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "luni/calendar"

require "minitest/autorun"

# Require all support files
Dir[File.expand_path("support/**/*.rb", __dir__)].each { |f| require f }
