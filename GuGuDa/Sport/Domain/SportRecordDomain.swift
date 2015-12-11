//
//  SportRecordDomain.swift
//  GuGuDa
//
//  Created by boli on 12/11/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation
import SwiftyJSON

class SportRecordDomain {
    
    /// 用户ID
    var userID : Int
    
    /// 此次运动时间
    var date : String

    /// 运动所在城市
    var location : String

    /// 运动经纬度数组
    var records : [(latitude : Double, longitude : Double)]

    init(userID : Int, location : String, records : [(latitude : Double, longitude : Double)]) {
        self.userID = userID
        date = DateUtils.getDatabaseFormatString(NSDate())
        self.location = location
        self.records = records
    }
    
}