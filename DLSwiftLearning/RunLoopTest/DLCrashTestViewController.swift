//
//  DLCrashTestViewController.swift
//  DLSwiftLearning
//
//  Created by denglong on 26/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit

class DLCrashTestViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let a:Int? = nil
        print(a!)
    }

}
