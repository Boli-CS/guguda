//
//  FileUtils.swift
//  GuGuDa
//
//  Created by boli on 12/8/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation


class FileUtils {
    static func getFileName(fileName : String!) -> String {
        if fileName.containsString("/") {
            return fileName.substringFromIndex(fileName.lastIndexOf("/")!.advancedBy(1))
        }
        return fileName
    }
}