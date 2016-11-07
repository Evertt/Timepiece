//
//  Date+Timepiece.swift
//  Timepiece
//
//  Created by Naoto Kaneko on 10/2/16.
//  Copyright © 2016 Naoto Kaneko. All rights reserved.
//

import Foundation

extension Date {
    public enum Weekday: Int {
        case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    }
    
    /// The year.
    public var year: Int {
        return dateComponents.year!
    }

    /// The month.
    public var month: Int {
        return dateComponents.month!
    }

    /// The day.
    public var day: Int {
        return dateComponents.day!
    }

    /// The hour.
    public var hour: Int {
        return dateComponents.hour!
    }

    /// The minute.
    public var minute: Int {
        return dateComponents.minute!
    }

    /// The second.
    public var second: Int {
        return dateComponents.second!
    }

    /// The nanosecond.
    public var nanosecond: Int {
        return dateComponents.nanosecond!
    }

    /// The weekday.
    public var weekday: Int {
        return dateComponents.weekday!
    }

    private var dateComponents: DateComponents {
        return dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .nanosecond, .weekday])
    }
    
    private func dateComponents(_ components: Set<Calendar.Component>) -> DateComponents {
        return calendar.dateComponents(components, from: self)
    }

    // Returns user's calendar to be used to return `DateComponents` of the receiver.
    private var calendar: Calendar {
        return .current
    }

    /// Creates a new instance with specified date components.
    ///
    /// - parameter era:        The era.
    /// - parameter year:       The year.
    /// - parameter month:      The month.
    /// - parameter day:        The day.
    /// - parameter hour:       The hour.
    /// - parameter minute:     The minute.
    /// - parameter second:     The second.
    /// - parameter nanosecond: The nanosecond.
    /// - parameter calendar:   The calendar used to create a new instance.
    ///
    /// - returns: The created `Date` instance.
    public init(era: Int?, year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int, on calendar: Calendar) {
        let now = Date()
        var dateComponents = calendar.dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .nanosecond], from: now)
        dateComponents.era = era
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        dateComponents.nanosecond = nanosecond

        let date = calendar.date(from: dateComponents)
        self.init(timeInterval: 0, since: date!)
    }

    /// Creates a new instance with specified date componentns.
    ///
    /// - parameter year:       The year.
    /// - parameter month:      The month.
    /// - parameter day:        The day.
    /// - parameter hour:       The hour.
    /// - parameter minute:     The minute.
    /// - parameter second:     The second.
    /// - parameter nanosecond: The nanosecond. `0` by default.
    ///
    /// - returns: The created `Date` instance.
    public init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int = 0) {
        self.init(era: nil, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond, on: .current)
    }

    /// Creates a new Instance with specified date components
    ///
    /// - parameter year:  The year.
    /// - parameter month: The month.
    /// - parameter day:   The day.
    ///
    /// - returns: The created `Date` instance.
    public init(year: Int, month: Int, day: Int) {
        self.init(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
    }
    
    /// Creates a new instance representing now.
    ///
    /// - returns: The created `Date` instance representing now.
    public static var now: Date {
        return Date()
    }

    /// Creates a new instance representing today.
    ///
    /// - returns: The created `Date` instance representing today.
    public static var today: Date {
        let now = Date.now
        return Date(year: now.year, month: now.month, day: now.day)
    }

    /// Creates a new instance representing yesterday
    ///
    /// - returns: The created `Date` instance representing yesterday.
    public static var yesterday: Date {
        return (today - 1.day)!
    }

    /// Creates a new instance representing tomorrow
    ///
    /// - returns: The created `Date` instance representing tomorrow.
    public static var tomorrow: Date {
        return (today + 1.day)!
    }
    
    public static func next(_ weekday: Weekday, after reference: Date = today) -> Date {
        let nextWeekday = weekday.rawValue
        
        let difference = (nextWeekday + 7 - reference.weekday) % 7
        
        return (reference + difference.days)!
    }
    
    public static func last(_ weekday: Weekday, before reference: Date = today) -> Date {
        let prevWeekday = weekday.rawValue
        
        let difference = (reference.weekday + 7 - prevWeekday) % 7
        
        return (reference - difference.days)!
    }
    
    public static func next(_ period: Calendar.Component, after reference: Date = now) -> ClosedRange<Date> {
        var component = DateComponents()
        component.setValue(1, for: period)
        
        let nextDate = reference + component
        
        return nextDate!...reference
    }
    
    public static func last(_ period: Calendar.Component, before reference: Date = now) -> ClosedRange<Date> {
        var component = DateComponents()
        component.setValue(1, for: period)
        
        let lastDate = reference - component
        
        return lastDate!...reference
    }
    
    public func `in`(_ range: Range<Date>) -> Bool {
        return range.contains(self)
    }
    
    public func `in`(_ range: ClosedRange<Date>) -> Bool {
        return range.contains(self)
    }
    
    public func between(_ low: Date, and high: Date) -> Bool {
        var low = low, high = high
        
        if low > high {
            swap(&low, &high)
        }
        
        return self.in(low...high)
    }

    /// Creates a new instance added a `DateComponents`
    ///
    /// - parameter left:  The date.
    /// - parameter right: The date components.
    ///
    /// - returns: The created `Date` instance.
    public static func + (left: Date, right: DateComponents) -> Date? {
        return Calendar.current.date(byAdding: right, to: left)
    }

    /// Creates a new instance subtracted a `DateComponents`
    ///
    /// - parameter left:  The date.
    /// - parameter right: The date components.
    ///
    /// - returns: The created `Date` instance.
    public static func - (left: Date, right: DateComponents) -> Date? {
        return Calendar.current.date(byAdding: -right, to: left)
    }

    /// Creates a new `String` instance representing the receiver formatted in given date style and time style.
    ///
    /// - parameter dateStyle: The date style.
    /// - parameter timeStyle: The time style.
    ///
    /// - returns: The created `String` instance.
    public func string(inDateStyle dateStyle: DateFormatter.Style, andTimeStyle timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle

        return dateFormatter.string(from: self)
    }

    /// Creates a new `String` instance representing the date of the receiver formatted in given date style.
    ///
    /// - parameter dateStyle: The date style.
    ///
    /// - returns: The created `String` instance.
    public func dateString(in dateStyle: DateFormatter.Style) -> String {
        return string(inDateStyle: dateStyle, andTimeStyle: .none)
    }

    /// Creates a new `String` instance representing the time of the receiver formatted in given time style.
    ///
    /// - parameter timeStyle: The time style.
    ///
    /// - returns: The created `String` instance.
    public func timeString(in timeStyle: DateFormatter.Style) -> String {
        return string(inDateStyle: .none, andTimeStyle: timeStyle)
    }
    
    public func at(_ time: DateComponents) -> Date {
        return Date(year: year, month: month, day: day, hour: time.hour ?? 0, minute: time.minute ?? 0, second: 0)
    }
    
    public static func -(lhs: Date, rhs: Date) -> DateComponents {
        let components: Set<Calendar.Component>
        components = [.year, .month, .day, .hour, .minute, .second]
        
        return lhs.dateComponents(components) - rhs.dateComponents(components)
    }
}

public func next(_ weekday: Date.Weekday, after reference: Date = .today) -> Date {
    return Date.next(weekday, after: reference)
}

public func last(_ weekday: Date.Weekday, before reference: Date = .today) -> Date {
    return Date.last(weekday, before: reference)
}

public func next(_ period: Calendar.Component, after reference: Date = .now) -> ClosedRange<Date> {
    return Date.next(period, after: reference)
}

public func last(_ period: Calendar.Component, before reference: Date = .now) -> ClosedRange<Date> {
    return Date.last(period, before: reference)
}
