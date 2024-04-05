# This is the model you need to create so it can be inserted into the calendar
# To create an Event in the calendar you must implement the following on your model
# ```ruby
# class YourModel
#   def to_calendar_event
#     Luni::Event.new(starts_at: starting, ends_at: ending, attributes: {camp: self, name: name})
#   end
# end
# ```
# Whatever you pass in as attributes, will be available on the event / entries in the different calendar
# view as instance methods

class Luni::Event
  attr_accessor :starts_at, :ends_at, :attributes

  def initialize(starts_at:, ends_at:, attributes:)
    @starts_at = starts_at
    @ends_at = ends_at
    @attributes = attributes
  end

  def method_missing(method_name, *arguments, &block)
    if attributes.has_key?(method_name)
      attributes[method_name]
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    attributes.has_key?(method_name) || super
  end
end
