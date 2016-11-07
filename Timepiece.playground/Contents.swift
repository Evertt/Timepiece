import Foundation
import Timepiece

let now = Date()

// Initializer
Date(era: 235, year: 26, month: 8, day: 14, hour: 20, minute: 25, second: 43, nanosecond: 0, on: Calendar(identifier: .japanese))
Date(year: 2014, month: 8, day: 14, hour: 20, minute: 25, second: 43, nanosecond: 0)
Date(year: 2014, month: 8, day: 14, hour: 20, minute: 25, second: 43)
Date(year: 2014, month: 8, day: 14)

Date.today
Date.yesterday
Date.tomorrow

// The properties of Date
now.year
now.month
now.weekday
now.day
now.hour
now.minute
now.second
now.nanosecond

// Calculation
now + 1.year
now - 2.months
now + (3.weeks - 4.days + 5.hours)

1.year.later
1.year.ago
1.year.after(.tomorrow)

// Format
now.string(inDateStyle: .long, andTimeStyle: .medium)
now.dateString(in: .medium)
now.timeString(in: .short)

3.days.string(in: .full)

// Parse
"2014/8/14".date(fromFormat: "yyyy/MM/dd")
"2014-08-14T20:25:43+0900".dateFromISO8601Format()

func scheduleSomething(_ date: Date) {}
scheduleSomething(next(.friday).at(5.AM))

1.week.after(.now).at(9.20.AM)

let ref = 5.hours.ago
ref.in(last(.month))