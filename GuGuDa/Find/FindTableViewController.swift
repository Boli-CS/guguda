//
//  FindViewController.swift
//  GuGuDa
//
//  Created by boli on 11/9/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation
import UIKit

/// “发现”主界面
class FindTableViewController: UITableViewController{
    
    var findTableCellModels = Dictionary<String, [(String, String)]>()
    let findTableGroupNames = ["ba", "near", "compete", "other"]
    
    @IBOutlet var findTable_tableView: UITableView!
    
    @IBOutlet weak var find_BarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var QRCode_BarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化Cell对应的Model

        self.findTableCellModels.updateValue(
            [("GuDongBa.png", "咕咚吧")],
            forKey: self.findTableGroupNames[0]);
        self.findTableCellModels.updateValue(
            [("GuDongBa.png", "附近"), ("GuDongBa.png", "运动场地"), ("GuDongBa.png", "活动")],
            forKey: self.findTableGroupNames[1])
        self.findTableCellModels.updateValue(
            [("GuDongBa.png", "官方赛事"), ("GuDongBa.png", "俱乐部"), ("GuDongBa.png", "竞赛")],
            forKey: self.findTableGroupNames[2])
        self.findTableCellModels.updateValue(
            [("GuDongBa.png", "运动换礼"), ("GuDongBa.png", "微信好友排行")],
            forKey: self.findTableGroupNames[3])
        //去掉底部不显示的cell
        self.findTable_tableView.tableFooterView = UIView()
    }
    
    /**
     发现界面的查找按钮
     */
    @IBAction func find_findNavigationBarButtonItemClick(sender: AnyObject) {
        print("发现页面的查找按钮被点击")
    }
  
    @IBAction func QRCode_navigationBarButtonItemClick(sender: AnyObject) {
        print("发现页面的扫描二维码按钮被点击")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.findTableCellModels[self.findTableGroupNames[section]]?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.findTable_tableView.dequeueReusableCellWithIdentifier("findTableViewCell") as! FindTableViewCell
        cell.findCellTitle_imageView.image = UIImage(named: self.findTableCellModels[self.findTableGroupNames[indexPath.section]]![indexPath.item].0)
        cell.findCellTitle_label.text = self.findTableCellModels[self.findTableGroupNames[indexPath.section]]![indexPath.item].1
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(self.findTableCellModels[self.findTableGroupNames[indexPath.section]]![indexPath.item].1 + "被点击了")
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
}