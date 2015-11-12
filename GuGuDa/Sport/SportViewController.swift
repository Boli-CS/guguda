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
class SportViewController: UIViewController , MAMapViewDelegate, AMapLocationManagerDelegate {
    
    var locationManager : AMapLocationManager?
    
    var mapView : MAMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = AMapLocationManager()
        locationManager!.delegate = self
        locationManager!.startUpdatingLocation()
        //添加地图界面
        initMapView()
    }
    
    func initMapView() {
        mapView = MAMapView(frame: self.view.bounds)
        mapView!.delegate = self
        self.view.addSubview(mapView!)
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        print("获取新的地理位置")
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
    }
    
}