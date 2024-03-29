Time::DATE_FORMATS[:next_updated] = "Next updated at %I:%M %p %Z, %b %d"
Time::DATE_FORMATS[:long_twelve_hour] = "%B %e, %Y %l:%M %P"
Time::DATE_FORMATS[:month_date] = lambda { |time| time.strftime("%b #{time.day.ordinalize}") }
Time::DATE_FORMATS[:year_month_day] = "%Y-%m-%d"
Time::DATE_FORMATS[:iso8601] = "%Y-%m-%d %H:%M"
