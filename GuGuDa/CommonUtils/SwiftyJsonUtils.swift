//
//  JsonUtils.swift
//  GuGuDa
//
//  Created by boli on 12/11/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation
import SwiftyJSON

class SwiftyJsonUtils {
    static func convertPlainObjectToSwiftyJson(reflecting subject: Any!) -> JSON{
        
        return JSON(convertPlainObjectToStringDic(reflecting: subject))
    }
    
    static func convertPlainObjectToStringDic(reflecting subject: Any!) -> [String: AnyObject]{
        var dict = [String: AnyObject]()
        let mirror = Mirror(reflecting: subject)
        for (_, attr) in mirror.children.enumerate() {
            if let property_name = attr.label as String! {
                dict[property_name] = attr.value as? AnyObject
            }
        }
        return dict
    }
}