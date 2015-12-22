//
//  PostCircleViewControl.swift
//  GuGuDa
//
//  Created by boli on 12/20/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation
import Alamofire

class PostCircleViewControl : UIViewController,
    AMapSearchDelegate,
    AMapLocationManagerDelegate,
    UITextViewDelegate{
    
    /// 选择要上传的图片
    var choosedImage : UIImage?
    
    /// 要上传的图片的url
    var choosedImageUrl : NSURL?
    
    @IBOutlet weak var cancle_button: UIButton!
    
    @IBOutlet weak var post_button: UIButton!
    
    @IBOutlet weak var imagesToPost_ImageView: UIImageView!
    
    @IBOutlet weak var textToPost_textView: UITextView!
    
    @IBOutlet weak var emoji_button: UIButton!
    
    @IBOutlet weak var location_button: UIButton!
    
    let locationService : AMapSearchAPI = AMapSearchAPI()
    
    let locationManager : AMapLocationManager = AMapLocationManager()
    
    let textToPost_placeHolder = CommonUtils.GetLocalizationText("POST_NEW_CIRCLE_TEXT_TO_POST_PLACE_HOLDER")
    
    override func viewDidLoad() {
        print("viewDidLoad")
        if(choosedImage != nil) {
            imagesToPost_ImageView.image = choosedImage
        }
        //获取位置信息
        initLocationInfo()
        //用于设置textToPost的placeholder
        textToPost_textView.delegate = self
        textToPost_textView.text = textToPost_placeHolder
        textToPost_textView.textColor = UIColor.grayColor()
    }
    
    @IBAction func post_barButtonItem_click(sender: AnyObject) {
        Alamofire.upload(
            .POST,
            POST_NEW_CIRCLE,
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(fileURL: self.choosedImageUrl!, name: (self.choosedImageUrl?.lastPathComponent)!)
                //                multipartFormData.appendBodyPart(fileURL: rainbowImageURL, name: "rainbow")
            },
            encodingCompletion: { encodingResult in
                //                switch encodingResult {
                //                case .Success(let upload, _, _):
                //                    upload.responseJSON { response in
                //                        debugPrint(response)
                //                    }
                //                case .Failure(let encodingError):
                //                    print(encodingError)
                //                }
            }
        )
    }
    
    @IBAction func cancle_barButtonItem_click(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func initLocationInfo() -> Void {
        locationService.delegate = self
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    /**
     获取经纬度成功
     
     - parameter manager:
     - parameter location:
     */
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        print("获取经纬度成功")
        let regeo : AMapReGeocodeSearchRequest = AMapReGeocodeSearchRequest()
        regeo.location = AMapGeoPoint()
        regeo.location.latitude = CGFloat(location.coordinate.latitude)
        regeo.location.longitude = CGFloat(location.coordinate.longitude)
        locationService.AMapReGoecodeSearch(regeo)
    }
    
    /**
     获取经纬度成功
     
     - parameter manager:
     - parameter error:
     */
    func amapLocationManager(manager: AMapLocationManager!, didFailWithError error: NSError!) {
        print("获取经纬度失败")
    }
    
    /**
     获取地理位置信息
     
     - parameter request:
     - parameter response:
     */
    func onReGeocodeSearchDone(request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        if(response.regeocode != nil) {
            self.location_button.setTitle(response.regeocode.addressComponent.streetNumber.street, forState: .Normal)
            locationManager.stopUpdatingLocation()
        }
    }
    
    /**
    *  设置textToPost的placeholder
    */
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.grayColor() {
            textView.textColor = UIColor.blackColor()
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textToPost_textView.text.isEmpty {
            textToPost_textView.text = textToPost_placeHolder
            textToPost_textView.textColor = UIColor.grayColor()
        }
    }
}