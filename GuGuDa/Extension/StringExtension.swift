//
//  StringExtension.swift
//  GuGuDa
//
//  Created by boli on 12/8/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation

extension String {
    
    func lastIndexOf(subString : String) -> Index? {
        if let range : Range<Index> = self.rangeOfString(subString, options: .BackwardsSearch) {
            return range.startIndex
        }
        return Optional<Index>()
    }
}