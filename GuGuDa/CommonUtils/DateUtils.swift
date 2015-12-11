//
//  DateUtils.swift
//  GuGuDa
//
//  Created by boli on 12/11/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation

class DateUtils {
    
    private static let dateFormatter = NSDateFormatter()
    
    static func getDatabaseFormatString(date : NSDate) -> String{
        dateFormatter.dateFormat = "yyyy-M-d H:m:s"
        return dateFormatter.stringFromDate(date)
        
    }
}