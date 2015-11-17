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
class MineViewController: UIViewController {
    
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
    
    @IBOutlet weak var mine_health_scrollView: UIScrollView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initControls()
    }
    
    override func viewDidLayoutSubviews() {
        mine_scrollView.contentSize = CGSizeMake(mine_scrollView.frame.width, mine_scrollView.frame.height * 1.1)
    }
    
    func initControls() {
        self.mine_selfHeadPortrait_imageView.image = UIImage(named: "GuDongBa");
        
        
    }
    
    @IBAction func mine_historyRecord_button_clickUp(sender: AnyObject) {
        print("我的界面的历史记录按钮被点击")
    }
}