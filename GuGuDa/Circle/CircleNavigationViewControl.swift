//
//  CircleNavigationViewControl.swift
//  GuGuDa
//
//  Created by boli on 11/12/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation
import UIKit

class CircleNavigationViewControl: UINavigationController {
    
    @IBOutlet weak var circleNavigation_navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        self.circleNavigation_navigationBar.backgroundColor = UIColor.greenColor()
        }
    
}