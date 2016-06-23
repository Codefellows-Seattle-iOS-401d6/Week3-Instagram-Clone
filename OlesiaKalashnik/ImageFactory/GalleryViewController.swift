//
//  GalleryViewController.swift
//  ImageFactory
//
//  Created by Olesia Kalashnik on 6/22/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, Identity, Setupable, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.collectionViewLayout = CustomCollectionViewLayout()
        }
    }
    
    var posts = [Post]() {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    //View Controller Lifecycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setup()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupAppearance()
    }
    
    //MARK: UICollectionViewDataSource Methods
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
        cell.post = posts[indexPath.row]
        return cell
    }
    
    func setupAppearance() {
        self.navigationItem.title = "Gallery"
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    func setup() {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        spinner.color = UIColor.greenColor()
        spinner.hidesWhenStopped = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
        spinner.startAnimating()
        API.shared.GETPosts { (posts) in
            if let safePosts = posts {
                self.posts = safePosts
                spinner.stopAnimating()
                
            }
        }
        
    }
    
}
