//
//  GalleryViewController.swift
//  ImageFactory
//
//  Created by Olesia Kalashnik on 6/22/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, Identity, Setupable, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts = [Post]() {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    var selected = false
    
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
        let pinchGester = UIPinchGestureRecognizer(target: self, action: #selector(GalleryViewController.pinchedCollectionVC(_:)))
        self.collectionView.addGestureRecognizer(pinchGester)
        self.collectionView.collectionViewLayout = CustomCollectionViewLayout(columns: 3)
        
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
    
    func pinchedCollectionVC(sender: UIPinchGestureRecognizer) {
        let layout = self.collectionView.collectionViewLayout as! CustomCollectionViewLayout
        var columns = layout.columns
        switch sender.state {
        case .Began: fallthrough
        case .Ended:
            if sender.scale > 1.0 {
                columns += 1
            } else if sender.scale < 1.0 && columns > 1 {
                columns -= 1
            }
        default:
            columns = layout.columns
        }
        self.collectionView.setCollectionViewLayout(CustomCollectionViewLayout(columns: columns), animated: true)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !selected {
            self.collectionView.setCollectionViewLayout(CustomCollectionViewLayout(columns: 1), animated: true)
        } else {
            self.collectionView.setCollectionViewLayout(CustomCollectionViewLayout(columns: 3), animated: true)
        }
        self.selected = !selected
        self.collectionView.collectionViewLayout.invalidateLayout()
        
    }
    
}
