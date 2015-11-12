//
//  MessageViewController.swift
//  GuGuDa
//
//  Created by boli on 11/10/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation
import UIKit

/// “消息”主界面
class MessageTableViewController: UITableViewController {
    
    @IBOutlet var messageTable_tableView: UITableView!
    
    @IBOutlet weak var messageContacts_navigationBarButtonItem: UIBarButtonItem!
    
    let messageTableDataModel = [
        ("杰神", "李博是大神，求抱大腿", "15-06"),
        ("剑靓", "李博是大神，求抱大腿", "15-06")
    ]
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.messageTable_tableView.dequeueReusableCellWithIdentifier("messageTableViewCell") as! MessageTableViewCell
        cell.messageCell_messageTarget_Label.text = messageTableDataModel[indexPath.item].0
        cell.messageCell_messageContent_Label.text = messageTableDataModel[indexPath.item].1
        cell.messageCell_messageDate_Label.text = messageTableDataModel[indexPath.item].2
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageTableDataModel.count
    }
    
    @IBAction func messageContacts_navigationBarButtonClick(sender: AnyObject) {
        print("消息界面的联系人按钮被点击")
    }
    
}