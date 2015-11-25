//
//  MineViewController.swift
//  GuGuDa
//
//  Created by boli on 11/10/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation
import UIKit

/// “我的”主界面
class MineViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var mine_coin_barButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var mine_setting_barButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var mine_order_barButtonItem: UIBarButtonItem!
    
    @IBOutlet var mine_scrollView: UIScrollView!
    
    @IBOutlet weak var mine_selfBackgroundImage_imageView: UIImageView!
    
    @IBOutlet weak var mine_selfHeadPortrait_imageView: UIImageView!
    
    @IBOutlet weak var mine_userName_label: UILabel!
   
    @IBOutlet weak var mine_following_button: UIButton!
    
    @IBOutlet weak var mine_follower_button: UIButton!
    
    @IBOutlet weak var mine_sportGroup_button: UIButton!
    
    @IBOutlet weak var mine_health_view: UIView!
    
    @IBOutlet weak var mine_historyRecord_button: UIButton!
    
    @IBOutlet weak var mine_historyRecord_distance_label: UILabel!
    
    @IBOutlet weak var mine_recentMilestone_button: UIButton!
    
    @IBOutlet weak var mine_recentMilestone_time_label: UILabel!
    
    @IBOutlet weak var mine_recentMilestone_content_label: UILabel!
    
    @IBOutlet weak var mine_medal_button: UIButton!
    
    @IBOutlet weak var mine_medal_picture_imageView: UIImageView!
    
    @IBOutlet weak var mine_medal_name_label: UILabel!
    
    @IBOutlet weak var mine_friendRank_button: UIButton!
    
    @IBOutlet weak var mine_accessories_button: UIButton!
    
    @IBOutlet weak var mine_healthContent_scrollView: UIScrollView!
    
    @IBOutlet weak var mine_healthContentSteps_imageView: UIImageView!
    
    @IBOutlet weak var mine_healthContentSleep_imageView: UIImageView!
    
    @IBOutlet weak var mine_healthContentWeight_imageView: UIImageView!
    
    /// 健康栏的scrollview正在往左拉动
    var isDraggingLeft : Bool = false
    /// 健康栏的scrollview上次移动的X坐标
    var lastScrollViewContentOffsetX : CGFloat = 0
    /// 健康栏的scrollview是否足够靠近
    let isNearEnoughGap : Float = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        mine_healthContent_scrollView.delaysContentTouches = false
        initControls()
        
    }
    
    override func viewDidLayoutSubviews() {
        mine_scrollView.contentSize = CGSizeMake(mine_scrollView.frame.width, mine_scrollView.frame.height * 1.1)
        mine_healthContent_scrollView.contentSize = CGSizeMake(mine_healthContentSleep_imageView.frame.width + mine_healthContentSteps_imageView.frame.width + mine_healthContentWeight_imageView.frame.width, mine_healthContent_scrollView.frame.height)
        
        mine_healthContent_scrollView.addConstraint(NSLayoutConstraint(item: mine_healthContentSleep_imageView, attribute: .Width, relatedBy: .Equal, toItem: mine_healthContentSteps_imageView, attribute: .Width, multiplier: 1, constant: 0))
        mine_healthContent_scrollView.addConstraint(NSLayoutConstraint(item: mine_healthContentWeight_imageView, attribute: .Width, relatedBy: .Equal, toItem: mine_healthContentSteps_imageView, attribute: .Width, multiplier: 1, constant: 0))
    }
    
    func initControls() {
        self.mine_selfHeadPortrait_imageView.image = UIImage(named: "GuDongBa");
        mine_healthContent_scrollView.delegate = self
        
    }
    
    @IBAction func mine_historyRecord_button_clickUp(sender: AnyObject) {
        print("我的界面的历史记录按钮被点击")
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scrollViewWillEndDragging")
        isDraggingLeft = true
        
        let disToStep = self.mine_healthContent_scrollView.contentOffset.x
        let disToSleep = abs(self.mine_healthContent_scrollView.contentOffset.x - self.mine_healthContentSteps_imageView.frame.width)
        let disToWeight = abs(self.mine_healthContent_scrollView.contentOffset.x - self.mine_healthContentSteps_imageView.frame.width - self.mine_healthContentSleep_imageView.frame.width)
        switch min(disToStep, disToSleep, disToWeight) {
        case disToStep:
            print("Set to Step")
            targetContentOffset.memory = (CGPointMake(mine_healthContentSteps_imageView.frame.origin.x, self.mine_healthContent_scrollView.contentOffset.y))
        case disToSleep:
            print("Set to Sleep")
            targetContentOffset.memory = CGPointMake(mine_healthContentSleep_imageView.frame.origin.x, self.mine_healthContent_scrollView.contentOffset.y)
        case disToWeight:
            print("Set to weight")
            targetContentOffset.memory = CGPointMake(mine_healthContentWeight_imageView.frame.origin.x, self.mine_healthContent_scrollView.contentOffset.y)
        default: break
        }
    }
    
    /**
     计算position是否足够接近target
     
     - parameter position: 当前值
     - parameter target:   目标值
     - parameter gap:      足够近的判断值，小于当前值足够近
     
     - returns:
     */
    func isPositionNearEnoughToTarget(position position : Float, target : Float, gap : Float) -> Bool {
        return abs(position - target) < gap
    }
}