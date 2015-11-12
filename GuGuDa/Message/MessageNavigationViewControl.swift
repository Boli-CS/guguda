//
//  MessageNavigationViewControl.swift
//  GuGuDa
//
//  Created by boli on 11/12/15.
//  Copyright © 2015 boli. All rights reserved.
//

import Foundation
import UIKit

class MessageNavigationViewControl: UINavigationController {
    
    @IBOutlet weak var message_navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        self.message_navigationBar.backgroundColor = UIColor.greenColor()
    }
}
