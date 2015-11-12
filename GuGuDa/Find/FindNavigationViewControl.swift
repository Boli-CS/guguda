//
//  FindNavigationViewControl.swift
//  GuGuDa
//
//  Created by boli on 11/12/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation
import UIKit

class FindNavigationViewControl: UINavigationController {
    
    @IBOutlet weak var findNavigationBar_NavigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        self.findNavigationBar_NavigationBar.backgroundColor = UIColor.greenColor()
    }
    
    
}