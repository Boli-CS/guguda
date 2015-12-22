//
//  LocalizationUtils.swift
//  GuGuDa
//
//  Created by boli on 12/20/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation

class CommonUtils {
    static func GetLocalizationText(globalText : String) -> String {
        var text = NSLocalizedString(globalText, comment: globalText)
        if text.isEmpty {
            text = NSLocalizedString("CAN_NOT_FIND_LOCALIZATION_TEXT", comment: "CAN_NOT_FIND_LOCALIZATION_TEXT")
        }
        return text
    }
}