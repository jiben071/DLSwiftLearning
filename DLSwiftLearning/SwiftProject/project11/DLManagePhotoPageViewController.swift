//
//  DLManagePhotoPageViewController.swift
//  DLSwiftLearning
//
//  Created by denglong on 28/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//  分页管理器  广告页  图片轮播展示

import UIKit

class DLManagePhotoPageViewController: UIPageViewController {
    
    var photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    var currentIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        //用法：newValue = optionalValue ?? value
        //若optionalValue非nil时，newValue的值为optionalValue的值，若optionalValue为nil时，newValue的值为value的值
        //作用是保证currentIndex就算为nil也可以用一个0替代
        if let viewController =  viewPhotoCommentController(index: currentIndex ?? 0){
            let viewControllers = [viewController]
            //点击进来是第几页，就显示是第几页
            setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        }
    }

    fileprivate func viewPhotoCommentController(index: Int) -> DLPhotoCommentViewController? {
        if let storyboard = storyboard,
            let page = storyboard.instantiateViewController(withIdentifier: "PhotoCommentViewController") as? DLPhotoCommentViewController{
            page.photoName = photos[index]
            page.photoIndex = index
            return page
        }
        
        return nil
    }


}

extension DLManagePhotoPageViewController: UIPageViewControllerDataSource{
    //上一页
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? DLPhotoCommentViewController {
            guard let index = viewController.photoIndex, index != 0 else {
                return nil
            }
            return viewPhotoCommentController(index: index - 1)
        }
        return nil
    }
    
    //下一页
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? DLPhotoCommentViewController{
            guard let index = viewController.photoIndex, index != photos.count - 1 else {
                return nil
            }
            return viewPhotoCommentController(index: index + 1)
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photos.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex ?? 0
    }
}
