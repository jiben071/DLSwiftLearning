//
//  UIImageExtension.swift
//  DLSwiftLearning
//
//  Created by denglong on 28/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit

class UIImageExtension: UIImage {

}

extension UIImage {
    //绘制图片的缩略图
    func thumbnailOfSize(_ size: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: size, height: size))
        let rect = CGRect(x: 0.0, y: 0.0, width: size, height: size)
        UIGraphicsBeginImageContext(rect.size)  //为什么用了两次 UIGraphicsBeginImageContext
        draw(in: rect)
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return thumbnail!
    }
}
