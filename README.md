# Luni::Calendar

## GOAL

Provide all the tools to creat you own custom calendar with handling of all the difficult stuff for you.

It comes with some template generators, but the markup of the calendar is fully up to you.

Basic ideas:

- Supports any kind of view (day, week, monthly, n-day, only certain time frame of hours, lists of dates)
- It slices up events into chunkz for calendar display, the event may cross day lines or only part of the event is displayed
- It gives you helpers for inline styles that can position the calendar chunkz in a day or a week view, where they can overlap or be displayed next to each other.

## Classes

```ruby
class Event
  def to_calendar_entries
    # Logic here to decide what kind of Entry(s) to generate
  end
end

class Entry
  # Shared logic for all entries
end

class FullDayEntry < Entry
  # Specific logic for full-day entries
end

class EarlyDayEntry < Entry
  # Specific logic for early-day entries
end
```

class CalendarView
def split_event_into_entries(event)
raise NotImplementedError, "This method must be implemented by the subclass"
end
end

class ListCalendar < CalendarView
def split_event_into_entries(event) # Logic to split event into DayEntry objects
end
end

```
class MonthCalendar < CalendarView
  def split_event_into_entries(event)
    # Logic to split event into HorizontalDaysEntry objects
  end
end

class WeekCalendar < CalendarView
  def split_event_into_entries(event)
    # Logic to split or categorize event into PositionedDayEntry or FullDayEntry objects
  end
end

class DayCalendar < CalendarView
  def split_event_into_entries(event)
    # Logic for EarlyHoursEntry, LateHoursEntry, etc.
  end
end
```

To develop a comprehensive and adaptable calendar gem that efficiently handles multi-day events and manages overlapping events across different views, the following design decisions have been made:

## Event and Entry Distinction

- **Events**: Represent the actual occurrences, serving as the source of information.
- **Entries**: Serve as the visual representation of these events within the calendar, adapted for different calendar views (List, Month, Week, Day).

This distinction enhances clarity, facilitating an easy differentiation between the data model (events) and their representation in the calendar (entries).

## Calendar Views and Entry Transformation

- Specific **calendar views** (`ListCalendar`, `MonthCalendar`, `WeekCalendar`, `DayCalendar`) are tasked with transforming events into the appropriate entry types (`DayEntry`, `HorizontalDaysEntry`, `PositionedDayEntry`, etc.), according to the view’s specific layout and requirements.
- This approach allows for customized logic in splitting events into entries for each view, ensuring accurate representation.

## Handling Overlapping Events

- To manage overlapping events effectively, a two-step process is proposed:
  1. **Slicing**: Initially divide events into view-appropriate entries.
  2. **Positioning**: Subsequently adjust these entries to handle overlaps, determining their visual properties (e.g., width, position) for a clear and coherent display.

This sequential process provides the flexibility needed to manage overlaps without complicating the initial transformation of events into entries.

## Connectivity and Context

- Maintaining a **reference** from each entry back to its original event allows for the consideration of additional context during the positioning phase. This approach is essential for optimizing the arrangement of entries and applying specific display logic based on the characteristics of the events.

## Encapsulation and Flexibility

- Introducing an **EntryPositioningService** (or a similar mechanism) to encapsulate the complexity of adjusting entries for overlap allows for the application of sophisticated logic, including event priorities, grouping, and dynamic presentation adjustments.
- This abstraction ensures the system's flexibility and extensibility, facilitating future enhancements or the addition of new entry types and calendar views with minimal impact on existing code.

## Conclusion

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG

## Usage

The Gem can be used like this:

in your controller:

```ruby
def index
  @camps = Camps.where(start_on: (params[:from])..(params[:to])).or(Camps.where(end_on: (params[:from])..(params[:to]))
  @list_calendar = Luni::ListView.new(@camps)
end
```

To be properly handled by the ListView or any other view, you need to have the following on your model

```ruby
class Camps
  def to_calendar_event
    Luni::Event.new(starts_at: starting, ends_at: ending, data: {camp: self, name: name})
  end
end
```

In the view you do:

or you create the views yourself:

````erb
<%= @list_calendar.days each do |day| %>
  <%= l(day, :pretty)>
  <% day.entries.each do |entry| %>
    <%= entry.name %>
    <%= entry.camp.category %>
  <% end %>
<% end %>

TODO: month view example, and so on, where things get trickier, but something like, note
that I might provide different strategies, such as a month calendar where every event has an entry
per day, and another strategy where entries can span multiple days.

```erb
<%= @month_calendar.week.each do |week| %>
  <calendar-week class="<%= week.styles %>">
    <%= week.days.each do |day| %>
        <calendar-day class="<%= day.styles %>">
            handles the entries for a specific day
            +more entries, if there is a limit on entries per day
        </calendar-day>
    <% end %>
    <% week.multi_day_entries do %>
        Handles the entries that span multiple days
    <% end>
  </calendar-week>





## Open Questions

- How to handle things without duration? Maybe I want to include non duration things in my calendar such as reminders…


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/luni-calendar.
````
