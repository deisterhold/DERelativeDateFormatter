//
//  DERelativeDateFormatter.swift
//  TableViewDateHeader
//
//  Created by Daniel Eisterhold on 5/13/16.
//  Copyright © 2016 Daniel Eisterhold. All rights reserved.
//

import Foundation

class DERelativeDateFormatter: NSDateFormatter {
    let cal:NSCalendar!
    var components:NSDateComponents!
    let monthAfterNext:NSDate!
    let nextMonth:NSDate!
    let weekAfterNext:NSDate!
    let nextWeek:NSDate!
    let dayAfterNext:NSDate!
    let tomorrow:NSDate!
    let today:NSDate!
    let thisWeek:NSDate!
    let thisMonth:NSDate!
    let yesterday:NSDate!
    let lastWeek:NSDate!
    let lastMonth:NSDate!
    
    override init() {
        // Set the current calendar
        cal = NSCalendar.currentCalendar()
        
        // Get the current hour, minute, and seconds since the start of today
        components = cal.components([NSCalendarUnit.Hour, .Minute, .Second], fromDate: NSDate())
        
        // Make all of the components negative
        components.hour *= -1
        components.minute *= -1
        components.second *= -1
        
        // Calculate midnight by substracting the amount of time since the start of the day
        today = cal.dateByAddingComponents(components, toDate: NSDate(), options: .MatchStrictly)!
        
        // Calculate tomorrow by adding one day from today
        components.hour = 24
        components.minute = 0
        components.second = 0
        tomorrow = cal.dateByAddingComponents(components, toDate: today, options: .MatchStrictly)!
        
        // Calculate day after tomorrow by adding two days to today
        components.hour = 48
        dayAfterNext = cal.dateByAddingComponents(components, toDate: today, options: .MatchStrictly)!
        
        // Calculate yesterday by substracting one day from today
        components.hour = -24
        components.minute = 0
        components.second = 0
        yesterday = cal.dateByAddingComponents(components, toDate: today, options: .MatchStrictly)!
        
        // Calculate this week by subtracting the days since the start of the week
        components = cal.components([.Weekday, .Year, .Month, .Day], fromDate: today)
        components.day -= (components.weekday - 1)
        thisWeek = cal.dateFromComponents(components)
        
        // Calculate next week by adding one week from the start of this week
        components.day += 7
        nextWeek = cal.dateFromComponents(components)
        
        // Calculate week after next by adding two weeks from start of this week
        components.day += 7
        weekAfterNext = cal.dateFromComponents(components)
        
        // Calculate last week by subtring two weeks from the start of next week
        components.day -= 21
        lastWeek = cal.dateFromComponents(components)
        
        // Calculate this month by substracting the days since the start of the month
        components.day = components.day - (components.day - 1)
        thisMonth = cal.dateFromComponents(components)
        
        // Calculate next month by adding one month since the start of this month
        components.month += 1
        nextMonth = cal.dateFromComponents(components)
        
        // Calculate month after next by adding two months since the start of this month
        components.month += 1
        monthAfterNext = cal.dateFromComponents(components)
        
        // Calculate last month by subtracting two months since the start of next month
        components.month -= 3
        lastMonth = cal.dateFromComponents(components)
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        fatalError("encodeWithCoder(aCoder:) has not been implemented")
    }
    
    override func stringForObjectValue(obj: AnyObject) -> String? {
        if let dateToFormat = obj as? NSDate {
            // Before last month
            if(lastMonth.compare(dateToFormat) == .OrderedDescending) {
                return "A While Ago"
            }
                // Last Month
            else if(thisMonth.compare(dateToFormat) == .OrderedDescending) {
                return "Last Month"
            }
                // This Month
            else if(nextMonth.compare(dateToFormat) == .OrderedDescending) {
                // Before last week
                if(lastWeek.compare(dateToFormat) == .OrderedDescending) {
                    return "This Month"
                }
                    // Last week
                else if(thisWeek.compare(dateToFormat) == .OrderedDescending) {
                    return "Last Week"
                }
                    // This Week
                else if(nextWeek.compare(dateToFormat) == .OrderedDescending) {
                    // Before yesterday
                    if(yesterday.compare(dateToFormat) == .OrderedDescending) {
                        return "This Past Week"
                    }
                        // Yesterday
                    else if(today.compare(dateToFormat) == .OrderedDescending) {
                        return "Yesterday"
                    }
                        // Today
                    else if(tomorrow.compare(dateToFormat) == .OrderedDescending) {
                        return "Today"
                    }
                        // Tomorrow
                    else if(dayAfterNext.compare(dateToFormat) == .OrderedDescending) {
                        return "Tomorrow"
                    }
                        // After tomorrow
                    else {
                        return "Later This Week"
                    }
                }
                    // Next Week
                else if(weekAfterNext.compare(dateToFormat) == .OrderedDescending) {
                    return "Next Week"
                }
                    // After next week
                else {
                    return "Later This Month"
                }
            }
                // Next month
            else if(monthAfterNext.compare(dateToFormat) == .OrderedDescending) {
                return "Next Month"
            }
                // After next month
            else {
                return "Upcoming"
            }
        }
        else {
            return nil
        }
    }
    
    override func getObjectValue(obj: AutoreleasingUnsafeMutablePointer<AnyObject?>, forString string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>) -> Bool {
        switch(string) {
        case "A While Ago":
            obj.memory = NSDate.distantPast()
            return true
        case "Last Month":
            obj.memory = self.lastMonth
            return true
        case "This Month":
            obj.memory = self.thisMonth
            return true
        case "Last Week":
            obj.memory = self.lastWeek
            return true
        case "This Past Week":
            obj.memory = self.thisWeek
            return true
        case "Yesterday":
            obj.memory = self.yesterday
            return true
        case "Today":
            obj.memory = self.today
            return true
        case "Tomorrow":
            obj.memory = self.tomorrow
            return true
        case "Later This Week":
            obj.memory = self.thisWeek
            return true
        case "Next Week":
            obj.memory = self.nextWeek
            return true
        case "Later This Month":
            obj.memory = self.thisMonth
            return true
        case "Next Month":
            obj.memory = self.nextMonth
            return true
        case "Upcoming":
            obj.memory = NSDate.distantFuture()
            return true
        default:
            obj.memory = nil
            return false
        }
    }
}