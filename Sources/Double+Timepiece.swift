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
    
    var AM: DateComponents? {
        return timeComponents(period: .AM)
    }
    
    var PM: DateComponents? {
        return timeComponents(period: .PM)
    }
    
    private func timeComponents(period: Period) -> DateComponents {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let string = String(format: "%.2f \(period)", self)
        
        guard let date = formatter.date(from: string) else {
            fatalError("Please provide a valid time.")
        }
        
        return DateComponents(hour: date.hour, minute: date.minute)
    }
}
