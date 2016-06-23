//
//  GalleryViewController.swift
//  ISTGRM
//
//  Created by David Swaintek on 6/22/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setupAppearance() {
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.title = "Sick Pics"
    }
    
    func update() {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
        
        API.shared.GET{ (posts) in
            if let posts = posts {
            self.posts = posts
            }
        }
    }
    
    var posts = [Post]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    
    class func id() -> String{
        return String(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
        API.shared.GET { (posts) in
            if let posts = posts {
                self.posts = posts
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection: Int) -> Int
    {
        return posts.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: cellForItemAtIndexPath) as! ImageCollectionViewCell
        
        cell.post = self.posts[cellForItemAtIndexPath.row]
        return cell
    }
    
}
