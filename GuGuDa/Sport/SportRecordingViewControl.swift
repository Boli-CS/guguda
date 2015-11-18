//
//  SportRecordingViewControl.swift
//  GuGuDa
//
//  Created by boli on 11/17/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation
import UIKit

class SportRecordingViewControl: UIViewController, MAMapViewDelegate, AMapLocationManagerDelegate  {
    
    @IBOutlet weak var sportRecording_distance_label: UILabel!
    
    @IBOutlet weak var sportRecording_time_label: UILabel!
    
    @IBOutlet weak var sportRecording_averageSpeed_label: UILabel!
    
    @IBOutlet weak var sportRecording_pace_labe: UILabel!
    
    @IBOutlet weak var sportRecording_calorie_label: UILabel!
    
    @IBOutlet weak var sportRecoding_mapView_view: UIView!
    
    var mapView : MAMapView?
    
    var locationManager : AMapLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
}