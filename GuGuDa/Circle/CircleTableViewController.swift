//
//  CircleViewController.swift
//  GuGuDa
//
//  Created by boli on 11/8/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation
import UIKit

/// "运动圈"主界面
class CircleTableViewController: UITableViewController {

    @IBOutlet var circleTable_tableView: UITableView!
 
    @IBOutlet weak var circleTable_findFriends_BarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var circleTable_takePhotos_BarButtonItem: UIBarButtonItem!
    
    let circleTableViewDataModel = [
        ("GuDongBa.png", "Bob", "15", "2", "GuDongBa.png", "ShenZhen", "乌拉拉拉")
    ]
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.circleTableViewDataModel.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.circleTable_tableView.dequeueReusableCellWithIdentifier("CircleTableViewCell") as! CircleTableViewCell
        cell.circleCell_headPortrait_imageView.image = UIImage(named: self.circleTableViewDataModel[indexPath.item].0)
        cell.circleCell_userName_label.text = self.circleTableViewDataModel[indexPath.item].1
        cell.circleCell_sportDays_label.text = "运动第" + self.circleTableViewDataModel[indexPath.item].2 + "天"
        cell.circleCell_postDate_label.text = self.circleTableViewDataModel[indexPath.item].3 + "天前"
        cell.circleCell_postPictures_imageView.image = UIImage(named: self.circleTableViewDataModel[indexPath.item].4)
        cell.circleCell_postLocation_label.text = self.circleTableViewDataModel[indexPath.item].5
        cell.circleCell_postContent_label.text = self.circleTableViewDataModel[indexPath.item].6
        return cell
        
    }
    
    @IBAction func circleCell_commentButton_click(sender: UIButton) {
        print("运动圈的评论按钮被点击")
    }
    
    
    @IBAction func circleCell_likeButton_click(sender: UIButton) {
        print("运动圈的点赞按钮被点击")
    }
    
    @IBAction func circleCell_shareButton_click(sender: UIButton) {
        print("运动圈的分享按钮被点击")
    }
    
    
    @IBAction func circleTable_findFriends_click(sender: AnyObject) {
        print("运动圈界面找好友被点击")
    }
    
    @IBAction func circleTabel_takePhotos_click(sender: AnyObject) {
        print("运动圈界面照相被点击")
    }
    
    
}
