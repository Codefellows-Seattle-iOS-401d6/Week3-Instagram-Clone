//
//  FiltersPreviewViewController.swift
//  ImageFactory
//
//  Created by Olesia Kalashnik on 6/23/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

protocol FiltersPreviewViewControllerDelegate: class {
    func didFinishPickingImage(success: Bool, selectedImage: UIImage?)
}

class FiltersPreviewViewController: UIViewController, Identity {
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate : FiltersPreviewViewControllerDelegate?
    
    var filtersArray = [Filters.shared.original, Filters.shared.bw, Filters.shared.chrome, Filters.shared.fade, Filters.shared.invert, Filters.shared.vintage]
    
    var post = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = CustomCollectionViewLayout()
    }
    
}

extension FiltersPreviewViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filtersArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
        
        //configure cell
        self.filtersArray[indexPath.row](post.image, completion:
            {
                cell.imageView.image = $0
        })
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let delegate = self.delegate else { return }
        let imgCell = collectionView.cellForItemAtIndexPath(indexPath) as! ImageCollectionViewCell
        if let img = imgCell.imageView.image {
            delegate.didFinishPickingImage(true, selectedImage: img)
        } else {
            delegate.didFinishPickingImage(false, selectedImage: nil)
        }
    }
    
    
    
    
    
    
}

