//
//  DLPhotoCommentViewController.swift
//  DLSwiftLearning
//
//  Created by denglong on 28/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//

import UIKit

class DLPhotoCommentViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    
    public var photoName: String!
    public var photoIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let photoName = photoName {
            imageView.image = UIImage(named: photoName)
        }
        
        let generalTapGesture = UITapGestureRecognizer(target: self, action: Selector.generalTap)
        view.addGestureRecognizer(generalTapGesture)
        
        let zoomTapGesture = UITapGestureRecognizer(target: self, action: Selector.zoomTap)
        imageView.addGestureRecognizer(zoomTapGesture)
        
        NotificationCenter.default.addObserver(self, selector: Selector.keyboardWillShowHandler, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: Selector.keyboardWillHideHandler, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func adjustInsetForKeyboard(isShow: Bool, notification: Notification) {
        guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else{
            return
        }
        
        //达到scroll跟随键盘移动的效果
        let keyboardFrame = value.cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (isShow ? 1 : -1)
        
        scrollView.contentInset.bottom += adjustmentHeight  //内容移动
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight  //底部滚动条
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification){
        adjustInsetForKeyboard(isShow: true, notification: notification)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        adjustInsetForKeyboard(isShow: false, notification: notification)
    }
    
    @objc func openZoomingController(sender: AnyObject) {
        performSegue(withIdentifier: "zooming", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier,
            let zoomedPhotoViewController = segue.destination as? DLZoomedPhotoViewController{
            if id == "zooming" {
                zoomedPhotoViewController.photoName = photoName
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

fileprivate extension Selector {
    static let keyboardWillShowHandler = #selector(DLPhotoCommentViewController.keyboardWillShow(notification:))
    static let keyboardWillHideHandler = #selector(DLPhotoCommentViewController.keyboardWillHide(notification:))
    static let generalTap = #selector(DLPhotoCommentViewController.dismissKeyboard)
    static let zoomTap = #selector(DLPhotoCommentViewController.openZoomingController(sender:))
}
