//
//  SportViewController.swift
//  GuGuDa
//
//  Created by boli on 11/10/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation
import UIKit

/// “运动”主界面
class SportViewController: UIViewController, MAMapViewDelegate, AMapLocationManagerDelegate {
    
    /// 上侧标题栏运动模式选择按钮
    @IBOutlet weak var sport_topModeSelect_button: UIButton!
    
    var locationManager : AMapLocationManager?
    
    var mapView : MAMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加地图界面
        initMapView()
    }
    
    func initMapView() {
        locationManager = AMapLocationManager()
        locationManager!.delegate = self
        locationManager!.startUpdatingLocation()
        mapView = MAMapView(frame: self.view.bounds)
        mapView!.delegate = self
        self.view.addSubview(mapView!)
        mapView?.showsUserLocation = true
        mapView?.userTrackingMode = MAUserTrackingMode.Follow
        
        let gps_label = UILabel()
        gps_label.frame = CGRectMake(10, 70, 50, 20)
        gps_label.text = "GPS"
        self.view.addSubview(gps_label)
        
        let airQuality_label = UILabel()
        airQuality_label.frame = CGRectMake(350, 70, 50, 20)
        airQuality_label.text = "良"
        self.view.addSubview(airQuality_label)
        
        let startSport_button = UIButton(type: .Custom)
        startSport_button.frame = CGRectMake(100,450,200,200)
        startSport_button.setTitle("开始运动", forState: .Normal)
        startSport_button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        startSport_button.addTarget(self, action: "startSport_button_click:", forControlEvents: .TouchUpInside)
        self.view.addSubview(startSport_button)
        
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
//        print("获取新的地理位置")
//        print(location.coordinate.latitude)
//        print(location.coordinate.longitude)
    }
    
    func startSport_button_click(sender: UIButton) {
        print("开始运动")
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SportRecordingViewControl") as! SportRecordingViewControl
        self.locationManager?.stopUpdatingLocation()
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}