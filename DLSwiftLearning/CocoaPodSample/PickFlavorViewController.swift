//
//  PickFlavorViewController.swift
//  DLSwiftLearning
//
//  Created by denglong on 04/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD


class PickFlavorViewController: UIViewController {

    @IBOutlet weak var resultBoard: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.loadFlavors()  //加载网络请求
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showLoadingHUD() {
//        let hud = MBProgressHUD.showAdded(to: UIApplication.shared.windows.last!, animated: true)
//        hud.label.text = "Loading..."
        self.showHint("正在获取数据...")
//        self.showHud(in: self.view, hint: "正在获取数据...")
    }
    
    private func hideLoadingHUD() {
//        MBProgressHUD.hide(for: self.view, animated: true)
        self.hideHud()
    }
    
    fileprivate func loadFlavors() {
        self.showLoadingHUD()
        Alamofire.request("https://www.raywenderlich.com/downloads/Flavors.plist", method: HTTPMethod.get, parameters: nil, encoding: PropertyListEncoding(format: .xml, options: 0), headers: nil).responsePropertyList {
            [weak self] response in
            
            guard let strongSelf = self else {
                return
            }
            
            guard response.result.isSuccess,let dictionaryArray = response.result.value as? [[String: String]] else {
                return
            }
            
            print("result: \(dictionaryArray)")
            
            strongSelf.resultBoard.text = dictionaryArray.description;
//            strongSelf.hideLoadingHUD()
        }
    }
    


}
