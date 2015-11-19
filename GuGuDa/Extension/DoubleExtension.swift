//
//  DoubleExtension.swift
//  GuGuDa
//
//  Created by boli on 11/18/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}