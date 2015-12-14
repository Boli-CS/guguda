//
//  CircleViewController.swift
//  GuGuDa
//
//  Created by boli on 11/8/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

/// "运动圈"主界面
class CircleTableViewController: UITableViewController,AllowReloadTableView {

    @IBOutlet var circleTable_tableView: UITableView!
 
    @IBOutlet weak var circleTable_findFriends_BarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var circleTable_takePhotos_BarButtonItem: UIBarButtonItem!
    
    var customNavigationItemView : UIView?
    var circleTableViewDataModel = [CircleTableViewCellDomain]()
    
    let defaultFileManage = NSFileManager.defaultManager()
    var cachePath : NSURL?
    
    override func viewDidLoad() {
        cachePath = defaultFileManage.URLsForDirectory(NSSearchPathDirectory.CachesDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)[0]
        
        initNavigationBarTitleButton()
        getTableViewDataFromServer()
    }
    
    func reloadTableView() {
        self.circleTable_tableView.reloadData()
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
    
    func getTableViewDataFromServer() {
        print("enter CircleTableViewControl.getTableViewDataFromServer")
        Alamofire.request(.GET, GET_CIRCLE_TRENDS_TABLE_CELLS, parameters:["type" : "1"])
            .responseJSON { response in
                if response.result.value != nil {
                    let circleCellJson = JSON(response.result.value!)
                    print("从服务器获取到数据")
                    for (_,subJson):(String, JSON) in circleCellJson {
                        let circleTableViewCellDomain = CircleTableViewCellDomain()
                        circleTableViewCellDomain.userID = subJson["userID"].int
                        circleTableViewCellDomain.userName = subJson["userName"].string
                        circleTableViewCellDomain.sportDays = subJson["sportDays"].string
                        circleTableViewCellDomain.postDate = subJson["postDate"].string
                        circleTableViewCellDomain.postLocation = subJson["postLocation"].string
                        circleTableViewCellDomain.postContent = subJson["postContent"].string
                        circleTableViewCellDomain.headPortrait = subJson["headPortrait"].string
                        self.circleTableViewDataModel.append(circleTableViewCellDomain)
                    }
                    self.circleTable_tableView.reloadData()
                }
                else {
                    let netFailAlert = UIAlertController(title: NSLocalizedString("CIRCLE_NETWORK_CONNECT_FIAL_ALERT_TITLE", comment: "CIRCLE_NETWORK_CONNECT_FIAL_ALERT_TITLE"), message: NSLocalizedString("CIRCLE_NETWORK_CONNECT_FIAL_ALERT_MESSAGE", comment: "CIRCLE_NETWORK_CONNECT_FIAL_ALERT_MESSAGE"), preferredStyle: .Alert)
                    netFailAlert.addAction(UIAlertAction(title: NSLocalizedString("ALERT_OK", comment: "OK"), style: .Default, handler: {(alertAction : UIAlertAction) in
                        print("网络连接失败")}))
                    self.presentViewController(netFailAlert, animated: true, completion: nil)
                }
        }
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
    
        if self.circleTableViewDataModel[indexPath.item].headPortrait != nil
        && !defaultFileManage.fileExistsAtPath((cachePath?.URLByAppendingPathComponent(self.circleTableViewDataModel[indexPath.item].headPortrait!).path)!){
            CommonInteractionWithServer.downloadHeadPortrait(self.circleTableViewDataModel[indexPath.item].headPortrait, tableViewtoReload: self)
        }
        else if self.circleTableViewDataModel[indexPath.item].headPortrait != nil{
            cell.circleCell_headPortrait_imageView.image = UIImage(data: NSData(contentsOfURL: cachePath!.URLByAppendingPathComponent(self.circleTableViewDataModel[indexPath.item].headPortrait!))!)
        }
        else {
            cell.circleCell_headPortrait_imageView.image = UIImage(named: "GuDongBa")
        }

        cell.circleCell_userName_label.text = self.circleTableViewDataModel[indexPath.item].userName
        cell.circleCell_sportDays_label.text = "运动第" + self.circleTableViewDataModel[indexPath.item].sportDays! + "天"
        cell.circleCell_postDate_label.text = self.circleTableViewDataModel[indexPath.item].postDate
        cell.circleCell_postPictures_imageView.image = UIImage(named: self.circleTableViewDataModel[indexPath.item].postPictures![0])
        cell.circleCell_postLocation_label.text = self.circleTableViewDataModel[indexPath.item].postLocation
        cell.circleCell_postContent_label.text = self.circleTableViewDataModel[indexPath.item].postContent
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
        let directoryURL = self.defaultFileManage.URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)[0]
        let pathComponent = "1.png"
        let dic = directoryURL.URLByAppendingPathComponent(pathComponent)
//        Alamofire.upload(.POST, "http://localhost:8080/GuGuDa/circle/upload", file: dic)
        Alamofire.upload(
            .POST,
            POST_NEW_CIRCLE,
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(fileURL: dic, name: "1.png")
//                multipartFormData.appendBodyPart(fileURL: rainbowImageURL, name: "rainbow")
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
            }
        )
    }
    
}
