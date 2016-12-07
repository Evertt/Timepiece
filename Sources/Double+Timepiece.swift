//
//  Double+Timepiece.swift
//  Timepiece
//
//  Created by Evert van Brussel on 04/11/2016.
//  Copyright © 2016 Naoto Kaneko. All rights reserved.
//

import Foundation

public extension Double {
    enum Period: String {
        case AM, PM
    }
    
    var AM: DateComponents {
        return timeComponents(period: .AM)
    }
    
    var PM: DateComponents {
        return timeComponents(period: .PM)
    }
    
    private func timeComponents(period: Period) -> DateComponents {
        // First let's validate the value of self to be a valid time
        let strSelf = "\(self)"
        let range = NSMakeRange(0, strSelf.characters.count)
        let pattern = "^(1?\\d|2[0-3])(\\.[0-5]\\d?)?$"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        
        guard regex.numberOfMatches(in: strSelf, options: [], range: range) > 0 else {
            fatalError("Please provide a valid time.")
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let string = String(format: "%.2f \(period)", self)
        let date = formatter.date(from: string)!
        
        return DateComponents(hour: date.hour, minute: date.minute)
    }
}

public extension Double {
    var week: TimeInterval {
        return 7 * days
    }
    
    var weeks: TimeInterval {
        return week
    }
    
    var day: TimeInterval {
        return 24 * hours
    }
    
    var days: TimeInterval {
        return day
    }
    
    var hour: TimeInterval {
        return 60 * minutes
    }
    
    var hours: TimeInterval {
        return hour
    }
    
    var minute: TimeInterval {
        return 60 * seconds
    }
    
    var minutes: TimeInterval {
        return minute
    }
    
    var second: TimeInterval {
        return self
    }
    
    var seconds: TimeInterval {
        return second
    }
    
    var microsecond: TimeInterval {
        return 1e-6 * seconds
    }
    
    var microseconds: TimeInterval {
        return microsecond
    }
    
    var nanosecond: TimeInterval {
        return 1e-9 * seconds
    }
    
    var nanoseconds: TimeInterval {
        return nanosecond
    }
}
