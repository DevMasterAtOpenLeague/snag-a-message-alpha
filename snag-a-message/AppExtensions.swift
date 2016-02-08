//
//  AppExtensions.swift
//  snag-a-message
//
//  Created by Romaine on 2/6/16.
//  Copyright © 2016 Romaine Hinds. All rights reserved.
//

import Foundation

extension NSDate {
    struct Date {
        static let formatterOLTimestamp: NSDateFormatter = {
            let formatter = NSDateFormatter()
            formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)
            formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            formatter.dateFormat = "MMddyyHHmmssSSSS"
            return formatter
        }()
    }
    
    static func isExpired(timeStamp stamp: String) -> Bool {
        let current: Int = Int(NSDate().formattedTimestamp)!
        let given: Int = Int(stamp)!
        
        if current >= given {
            return true
        }else{
            return false
        }
    }
    var formattedTimestamp: String {
        return Date.formatterOLTimestamp.stringFromDate(self)
    }
}

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue}
            swap(&self[i], &self[j])
        }
    }
}

extension String {
    /**
     Shuffles the characters within this String.
     This happens without mutating the String itself.
     
     - returns: A new shuffled String.
    */
    func shuffle() -> String {
        var array = Array(self.characters)
        for _ in 1...5 {
            array.shuffle()
        }
        return String(array)
    }
}

extension String {
    
    /**
     Trims the String from the back by the *count* given
     **NOTE**
     This method mutates self.
     
     - param: The number of characters to remove from the back of this String.
     
     - returns: The trimmed String
    */
    mutating func trimFromEndBy(count: Int) -> String {
        var string = self
        let invertedCount = count * -1
        let endIndex = string.endIndex.advancedBy(invertedCount)
        string = string.substringToIndex(endIndex)
        self = string
        return self
    }
    
    func toUInt8Array() -> [UInt8]{
        let array: [UInt8] = Array(self.utf8)
        return array
    }
    
    func bytesToString(bytes: [UInt8]) -> String {
        let data = NSData(bytes: bytes)
        if let str = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
            return str
        }else{
            return "nil"
        }
    }
}