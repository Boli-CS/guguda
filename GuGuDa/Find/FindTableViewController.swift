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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.findTable_tableView.dataSource = self
        //初始化Cell对应的Model

        self.findTableCellModels.updateValue(
            [("gudongba.img", "咕咚吧")],
            forKey: self.findTableGroupNames[0]);
        self.findTableCellModels.updateValue(
            [("fujin.img", "附近"), ("yundongchangdi.img", "运动场地"), ("huodong.img", "活动")],
            forKey: self.findTableGroupNames[1])
        self.findTableCellModels.updateValue(
            [("guanfangsaishi.img", "官方赛事"), ("jvlebu.img", "俱乐部"), ("jingsai.img", "竞赛")],
            forKey: self.findTableGroupNames[2])
        self.findTableCellModels.updateValue(
            [("yundonghuanli.img", "运动换礼"), ("weixinhaoyoupaihang.img", "微信好友排行")],
            forKey: self.findTableGroupNames[3])
        //去掉底部不显示的cell
        self.findTable_tableView.tableFooterView = UIView()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.findTableCellModels[self.findTableGroupNames[section]]?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.findTable_tableView.dequeueReusableCellWithIdentifier("findTableViewCell") as! FindTableViewCell
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