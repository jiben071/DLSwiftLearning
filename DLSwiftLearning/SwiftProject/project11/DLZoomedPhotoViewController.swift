//
//  DLZoomedPhotoViewController.swift
//  DLSwiftLearning
//
//  Created by denglong on 28/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//  图片进行缩放，直接放在scrollView上即可实现


import UIKit

class DLZoomedPhotoViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    var photoName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: photoName)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        updateMinZoomScale(forSize: view.bounds.size)
    }
    
    fileprivate func updateConstraints(forSize size: CGSize) {
        let yOffset = max(0, (size.height - imageView.frame.height) * 0.5)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) * 0.5)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
    }
    
    fileprivate func updateMinZoomScale(forSize size: CGSize) {
        //时刻调整缩放比例  随着imageview的变大而缩小比例
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale,heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    

}


extension DLZoomedPhotoViewController: UIScrollViewDelegate {
    //指定可缩放的view
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    //已经进行缩放后
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraints(forSize: view.bounds.size)//每次缩放之后变更约束量
    }
}
