//
//  DLPhoroThunbnailCollectionViewController.swift
//  DLSwiftLearning
//
//  Created by denglong on 28/12/2017.
//  Copyright © 2017 ubtrobot. All rights reserved.
//  缩略图展示

import UIKit

private let reuseIdentifier = "Cell"

//展现图片缩略图
class DLPhoroThunbnailCollectionViewController: UICollectionViewController {

    
    fileprivate let reuseIdentifier = "PhotoCell"
    fileprivate let thumbnailSize:CGFloat = 70.0
    fileprivate let sectionInsets = UIEdgeInsets(top: 10, left: 5.0, bottom: 10.0, right: 5.0)
    fileprivate let photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell,
            let indexPath = collectionView?.indexPath(for: cell),
        let zoomedPhotoViewController = segue.destination as? DLZoomedPhotoViewController{
            zoomedPhotoViewController.photoName = "photo\(indexPath.row + 1)"
        }
        
        if let cell = sender as? UICollectionViewCell,
            let indexPath = collectionView?.indexPath(for: cell),
            let photoCommentViewController = segue.destination as? DLPhotoCommentViewController {
            photoCommentViewController.photoName = "photo\(indexPath.row + 1)"
        }
        
        if let cell = sender as? UICollectionViewCell,
            let indexPath = collectionView?.indexPath(for: cell),
            let managePageViewController = segue.destination as? DLManagePhotoPageViewController {
            managePageViewController.photos = photos
            managePageViewController.currentIndex = indexPath.row
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

}

// MARK: UICollectionViewDataSource
extension DLPhoroThunbnailCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath  ) as! DLPhotoCell
        let fullSizedImage = UIImage(named: photos[indexPath.row])
        cell.imageView.image = fullSizedImage?.thumbnailOfSize(thumbnailSize)
        return cell
    }
}


extension DLPhoroThunbnailCollectionViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: thumbnailSize, height: thumbnailSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}
