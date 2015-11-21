//
//  SportRecordingViewControl.swift
//  GuGuDa
//
//  Created by boli on 11/17/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation
import UIKit
import Darwin

class SportRecordingViewControl: UIViewController, MAMapViewDelegate, AMapLocationManagerDelegate {
    
    @IBOutlet weak var sportRecording_distance_label: UILabel!
    
    @IBOutlet weak var sportRecording_time_label: UILabel!
    
    @IBOutlet weak var sportRecording_averageSpeed_label: UILabel!
    
    @IBOutlet weak var sportRecording_pace_labe: UILabel!
    
    @IBOutlet weak var sportRecording_calorie_label: UILabel!
    
    @IBOutlet weak var sportRecoding_mapView_view: UIView!
    
    var mapView : MAMapView?
    
    var locationManager : AMapLocationManager?
    
    var i = 1;
    /// 上一次定位的位置
    var lastLocation : CLLocation?
    
    /// 定位开始时间
    var startTime : NSDate?
    
    /// 已经运动的距离
    var distance : Double?
    
    let stopWatch : StopWatch = StopWatch()
    
    /// 暂停、完成、继续按钮
    @IBOutlet weak var sportRecording_dragToPause_button: UIButton!
    
    /// 暂停和继续按钮的superView
    @IBOutlet weak var sportRecording_continueAndFinishButtonSuperView_view: UIView!
    
    var dragToPauseButtonOriginalPosition : CGPoint?
    var continueAndFinishSuperViewOriginalPosition : CGPoint?
    //
    let queue = NSOperationQueue()
    var uiUpdateTimer: NSTimer?
    override func viewDidLoad() {
        super.viewDidLoad()
        startTime = NSDate()
        distance = 0
        dragToPauseButtonOriginalPosition = sportRecording_dragToPause_button.center
        continueAndFinishSuperViewOriginalPosition = sportRecording_continueAndFinishButtonSuperView_view.center
        self.stopWatch.start()
        initMapView()
        uiUpdateTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateSportTimeLabel", userInfo: nil, repeats: true)

    }
    
    func initMapView() {
        locationManager = AMapLocationManager()
        locationManager!.delegate = self
//        locationManager?.distanceFilter = 2.0
        locationManager!.startUpdatingLocation()
        
        
        mapView = MAMapView(frame: sportRecoding_mapView_view.bounds)
        mapView!.delegate = self
        sportRecoding_mapView_view.addSubview(mapView!)
        mapView?.addSubview(sportRecording_dragToPause_button)
        mapView?.addSubview(sportRecording_continueAndFinishButtonSuperView_view)
        mapView?.showsUserLocation = true
        mapView?.userTrackingMode = MAUserTrackingMode.Follow
        mapView?.showsScale = false
        mapView?.showsCompass = false
    }
    
    /**
     定时更新时间label
     */
    func updateSportTimeLabel() {
//        print("enter updateSportTimeLabel")
        //运动持续时间
        let timeInterval = self.stopWatch.getSeconds()!
        //        print("时间间隔为:" + timeInterval.format(".5"))
        let hour : Int = (Int)(timeInterval / 3600)
        let minute : Int = (Int)((timeInterval - Double(hour) * 3600.0) / 60)
        let second = Int(timeInterval - Double(hour) * 3600.0 - Double(minute) * 60.0)
        self.sportRecording_time_label.text = "\(hour):\(minute):\(second)"

    }
    
    /**
     定位回调函数
     
     - parameter manager:
     - parameter location:
     */
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        print("重新获取位置成功")
        if lastLocation == nil {
            lastLocation = location
        }
        self.distance = self.distance! + lantitudeLongitudeDist(lastLocation!, location2: location)
        lastLocation = location
        self.sportRecording_distance_label.text = self.distance?.format(".1")
        
        let timeInterval = self.stopWatch.getSeconds()!
        //平均速度
        self.sportRecording_averageSpeed_label.text = (self.distance! / (timeInterval / 3600)).format(".1")

        //配速
        if self.distance != 0 {
            self.sportRecording_pace_labe.text = (timeInterval / 3600 / self.distance!).format(".1")
        }
        
        self.sportRecording_calorie_label.text = "\(timeInterval)"
        
    }
    
    /**
     定位失败
     
     - parameter manager:
     - parameter error:
     */
    func amapLocationManager(manager: AMapLocationManager!, didFailWithError error: NSError!) {
        let locationFailAlert = UIAlertController(
            title: NSLocalizedString("LOCATION_FAIL_ALERT_TITLE", comment: "LOCATION_FAIL_ALERT_TITLE"),
            message: NSLocalizedString("LOCATION_FAIL_ALERT_MESSAGE", comment: "LOCATION_FAIL_ALERT_MESSAGE"),
            preferredStyle: .Alert)
        locationFailAlert.addAction(UIAlertAction(
            title: NSLocalizedString("ALERT_OK", comment: "OK"),
            style: UIAlertActionStyle.Default,
            handler: {(alertAction : UIAlertAction) in
        print("确认定位失败")}))
        self.presentViewController(locationFailAlert, animated: true, completion: nil)
    }
    
    /**
    *  转化为弧度(rad)
    *
    *  @param d
    *
    *  @return 
    */
    private func rad(d : Double) -> Double
    {
    return d * M_PI / 180.0;
    }
    
    /**
     基于余弦定理求两经纬度距离
     
     - parameter location1:
     - parameter location2:
     
     - returns: 返回的距离，单位km
     */
    func lantitudeLongitudeDist( location1 : CLLocation, location2 : CLLocation) -> Double{
        var radLat1 = rad(location1.coordinate.latitude);
        var radLat2 = rad(location2.coordinate.latitude);
    
        var radLon1 = rad(location1.coordinate.longitude);
        var radLon2 = rad(location2.coordinate.longitude);
    
        if (radLat1 < 0) {
            radLat1 = M_PI / 2 + abs(radLat1);// south
        }
        if (radLat1 > 0) {
            radLat1 = M_PI / 2 - abs(radLat1);// north
        }
    
        if (radLon1 < 0) {
            radLon1 = M_PI * 2 - abs(radLon1);// west
        }
    
        if (radLat2 < 0) {
            radLat2 = M_PI / 2 + abs(radLat2);// south
        }
    
        if (radLat2 > 0) {
            radLat2 = M_PI / 2 - abs(radLat2);// north
        }
        
        if (radLon2 < 0) {
            radLon2 = M_PI * 2 - abs(radLon2);// west
        }
    
        let x1 = GlobalVariables.EARTH_RADIUS * cos(radLon1) * sin(radLat1);
        let y1 = GlobalVariables.EARTH_RADIUS * sin(radLon1) * sin(radLat1);
        let z1 = GlobalVariables.EARTH_RADIUS * cos(radLat1);
    
        let x2 = GlobalVariables.EARTH_RADIUS * cos(radLon2) * sin(radLat2);
        let y2 = GlobalVariables.EARTH_RADIUS * sin(radLon2) * sin(radLat2);
        let z2 = GlobalVariables.EARTH_RADIUS * cos(radLat2);
    
        let d = sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2) + pow(z1 - z2, 2));
        //余弦定理求夹角
        let theta = acos((pow(GlobalVariables.EARTH_RADIUS, 2) * 2 - d * d) / (2 * GlobalVariables.EARTH_RADIUS * GlobalVariables.EARTH_RADIUS));
        let dist = theta * GlobalVariables.EARTH_RADIUS;
        return dist;
    }
    
    @IBAction func dragToPauseButtonDrag(sender: AnyObject, forEvent event: UIEvent) {
//        print("下拉暂停按钮被拖拽")
        let button = sender as! UIButton
        let touchs = event.touchesForView(button)
        var touch : UITouch?
        for tmp in touchs! {
            touch = tmp
        }
        let previousLocation : CGPoint = touch!.previousLocationInView(button)
        let location : CGPoint = touch!.locationInView(button)
        let delta_y :CGFloat = location.y - previousLocation.y
        button.center = CGPointMake(button.center.x,
            button.center.y + delta_y);
        sportRecording_continueAndFinishButtonSuperView_view.center = CGPointMake(sportRecording_continueAndFinishButtonSuperView_view.center.x
            , sportRecording_continueAndFinishButtonSuperView_view.center.y - 2 * delta_y)
        
//        print(sportRecording_continueAndFinishButtonSuperView_view.center.y)
        if button.frame.origin.y + button.bounds.height > sportRecoding_mapView_view.bounds.height {
            sportRecording_dragToPause_button.center.y = continueAndFinishSuperViewOriginalPosition!.y
            sportRecording_continueAndFinishButtonSuperView_view.center.y = dragToPauseButtonOriginalPosition!.y
            self.stopWatch.pause()
            self.locationManager?.stopUpdatingLocation()
        }
    }
   
    /**
     继续运动按钮被点击
     
     - parameter sender:
     */
    @IBAction func sportRecording_contineButton_clickUp(sender: AnyObject) {
        print("继续运动了")
        sportRecording_dragToPause_button.center.y = dragToPauseButtonOriginalPosition!.y
        sportRecording_continueAndFinishButtonSuperView_view.center.y = continueAndFinishSuperViewOriginalPosition!.y
        self.stopWatch.resume()
        self.locationManager?.startUpdatingLocation()
    }
}