//
//  FiltersPreviewViewController.swift
//  INSTGRM
//
//  Created by hannah gaskins on 6/23/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit

class FiltersPreviewViewController: UIViewController, Identity {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate : FiltersPreviewViewControllerDelegate?
    
    let filters = [Filters.shared.original, Filters.shared.bw, Filters.shared.chrome, Filters.shared.vintage, Filters.shared.colorNoir, Filters.shared.poster]
    
    var post = Post()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
    
    // returning true hides this status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout(columns: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FiltersPreviewViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // implement collectionView Methods
    
    func configureCellForIndexPath(indexPath: NSIndexPath) -> ImageCollectionViewCell {
        
        let imageCell = self.collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
        
        // which ever filter is at which ever index path, give it our image, whatever the result of that is assign it to teh image view
        
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

