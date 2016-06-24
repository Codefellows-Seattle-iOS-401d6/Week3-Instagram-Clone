//
//  FiltersPreviewViewController.swift
//  picster
//
//  Created by Derek Graham on 6/23/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit

class FiltersPreviewViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: FiltersPreviewViewControllerDelegate?
    
    let filters = [Filters.shared.original, Filters.shared.bw, Filters.shared.chrome, Filters.shared.vintage, Filters.shared.instant, Filters.shared.process]
    
    var post = Post()
    
    class func id()-> String
    {
        return String(self)
        
    }

    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout(columns: 2)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension FiltersPreviewViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func configureCellForIndexAtPath(indexPath: NSIndexPath)->ImageCollectionViewCell
    {
        let imageCell = self.collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
        self.filters[indexPath.row](post.image, completion: {
            imageCell.imageView.image = $0
            imageCell.activityIndicator.stopAnimating()
        })
        
        return imageCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filters.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        return self.configureCellForIndexAtPath(indexPath)
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