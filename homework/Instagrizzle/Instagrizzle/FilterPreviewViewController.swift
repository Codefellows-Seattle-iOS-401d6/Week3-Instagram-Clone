//
//  FilterPreviewViewController.swift
//  Instagrizzle
//
//  Created by Sung Kim on 6/23/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class FilterPreviewViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: FiltersPreviewViewControllerDelegate?
    
    let filters = [Filters.shared.original, Filters.shared.bw, Filters.shared.chrome, Filters.shared.vintage, Filters.shared.sepia, Filters.shared.invert]
    
    var post = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    class func id() -> String {
        return String(self)
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout(columns: 2)
    }
}

extension FilterPreviewViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func configureCellForIndexPath(indexPath: NSIndexPath) -> ImageCollectionViewCell {
        let imageCell = self.collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
        
        self.filters[indexPath.row](post.image, completion: {imageCell.imageView.image = $0})
        return imageCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filters.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return self.configureCellForIndexPath(indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let delegate = self.delegate else { return }
        let imageCell = collectionView.cellForItemAtIndexPath(indexPath) as! ImageCollectionViewCell
        if let image = imageCell.imageView.image {
            delegate.didFinishPickingImage(true, image: image)
        } else {
            delegate.didFinishPickingImage(false, image: nil)
        }
    }
}
