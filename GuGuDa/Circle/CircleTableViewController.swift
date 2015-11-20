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
    
    var customNavigationItemView : UIView?
    let circleTableViewDataModel = [
        ("GuDongBa.png", "Bob1", "15", "2", "GuDongBa.png", "ShenZhen", "乌拉拉拉"),
        ("GuDongBa.png", "Bob2", "15", "2", "GuDongBa.png", "ShenZhen", "乌拉拉拉")
    ]
    
    override func viewDidLoad() {
        initNavigationBarTitleButton()
    }
    
    /**
     初始化运动圈上侧的动态、附近、广场三个按钮
     
     - returns:
     */
    func initNavigationBarTitleButton() {
        customNavigationItemView = UIView()
        
        let trendbutton : UIButton = UIButton(type: .Custom)
        var originalString: String = NSLocalizedString("CIRCLE_NAVIGATION_BAR_TRENDS", comment: "CIRCLE_NAVIGATION_BAR_TRENDS")
        var myString: NSString = originalString as NSString
        var trendSize: CGSize = myString.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(14.0)])
        trendSize.width = trendSize.width * 1.5
        trendbutton.setTitle(originalString, forState: .Normal)
        trendbutton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        let nearbybutton : UIButton = UIButton(type: .Custom)
        originalString = NSLocalizedString("CIRCLE_NAVIGATION_BAR_NEARBY", comment: "CIRCLE_NAVIGATION_BAR_NEARBY")
        myString = originalString as NSString
        var nearbySize = myString.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(14.0)])
        nearbySize.width = nearbySize.width * 1.5
        nearbybutton.titleLabel?.adjustsFontSizeToFitWidth = true
        nearbybutton.setTitle(originalString, forState: .Normal)
        nearbybutton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        let squarebutton : UIButton = UIButton(type: .Custom)
        originalString = NSLocalizedString("CIRCLE_NAVIGATION_BAR_SQUARE", comment: "CIRCLE_NAVIGATION_BAR_SQUARE")
        myString = originalString as NSString
        var squareSize = myString.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(14.0)])
        squareSize.width = squareSize.width * 1.5
        squarebutton.titleLabel?.adjustsFontSizeToFitWidth = true
        squarebutton.setTitle(originalString, forState: .Normal)
        squarebutton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        trendbutton.frame = CGRectMake(0, 0, trendSize.width, trendSize.height)
        nearbybutton.frame = CGRectMake(trendSize.width, 0, nearbySize.width, nearbySize.height)
        squarebutton.frame = CGRectMake(trendSize.width + nearbySize.width, 0, squareSize.width, squareSize.height)
        customNavigationItemView?.frame = CGRectMake(self.circleTable_tableView.frame.width / 2, 0, trendSize.width + nearbySize.width + squareSize.width, max(trendSize.height, nearbySize.height, squareSize.height))
        customNavigationItemView?.addSubview(trendbutton)
        customNavigationItemView?.addSubview(nearbybutton)
        customNavigationItemView?.addSubview(squarebutton)

        self.navigationItem.titleView = customNavigationItemView

        trendbutton.addTarget(self, action: "circleNavigationBar_trendButton_clickUp:", forControlEvents: .TouchUpInside)
        nearbybutton.addTarget(self, action: "circleNavigationBar_nearbyButton_clickUp:", forControlEvents: .TouchUpInside)
        squarebutton.addTarget(self, action: "circleNavigationBar_squareButton_clickUp:", forControlEvents: .TouchUpInside)

    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    func circleNavigationBar_trendButton_clickUp(sender : UIButton) {
        print("动态按钮被点击")
    }
    
    func circleNavigationBar_nearbyButton_clickUp(sender : UIButton) {
        print("附近按钮被点击")
    }
    
    func circleNavigationBar_squareButton_clickUp(sender : UIButton) {
        print("广场按钮被点击")
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
        //表示每个cell的按钮
        cell.circleCell_payAttention_button.tag = indexPath.item
        cell.circleCell_postComment_button.tag = indexPath.item
        cell.circleCell_like_button.tag = indexPath.item
        cell.circleCell_share_button.tag = indexPath.item
        return cell
        
    }
    
    @IBAction func circleCell_payAttentionButton_click(sender: AnyObject) {
        print("第\(sender.tag)个cell的运动圈的关注按钮被点击")
    }
    /**
     Cell的评论按钮
     
     - parameter sender:
     */
    @IBAction func circleCell_commentButton_click(sender: UIButton) {
        print("第\(sender.tag)个cell的运动圈的评论按钮被点击")
    }
    
    /**
     cell的点赞按钮
     
     - parameter sender:
     */
    @IBAction func circleCell_likeButton_click(sender: UIButton) {
        print("第\(sender.tag)个cell的运动圈的点赞按钮被点击")
    }
    
    /**
     cell的分享按钮
     
     - parameter sender:
     */
    @IBAction func circleCell_shareButton_click(sender: UIButton) {
        print("第\(sender.tag)个cell的运动圈的分享按钮被点击")
    }
    
    
    @IBAction func circleTable_findFriends_click(sender: AnyObject) {
        print("运动圈界面找好友被点击")
    }
    
    @IBAction func circleTabel_takePhotos_click(sender: AnyObject) {
        print("运动圈界面照相被点击")
    }
    
    
}
