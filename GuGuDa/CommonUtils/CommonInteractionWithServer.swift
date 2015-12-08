//
//  CommonInteractionWithServer.swift
//  GuGuDa
//
//  Created by boli on 12/8/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Alamofire

/// 需要和服务器进行交互的通用函数
class CommonInteractionWithServer {
    
    static let defaultFileManage = NSFileManager.defaultManager()
    
    static func downloadHeadPortrait(picturePathName : String!, tableViewtoReload : AllowReloadTableView!) -> Bool {
        return downloadPictureFromServer("\(DOWNLOAD_PICTURE_FROM_SERVER)?filePath=\(picturePathName)", tableViewtoReload: tableViewtoReload)
    }
    
    static func downloadPictureFromServer(url : String!, tableViewtoReload : AllowReloadTableView!) -> Bool {
        Alamofire.download(.GET, url) { temporaryURL, response in
            let directoryURL = self.defaultFileManage.URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)[0]
            let pathComponent = response.suggestedFilename
            let dic = directoryURL.URLByAppendingPathComponent(pathComponent!)
            tableViewtoReload.reloadTableView()
            return dic
        }
        
        return true
    }
}