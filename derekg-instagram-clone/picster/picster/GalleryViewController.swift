//
//  GalleryViewController.swift
//  picster
//
//  Created by Derek Graham on 6/22/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts = [Post](){
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    class func id()-> String {
        return String(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout()
        self.update()
    }
    
    func setupGalleryViewControllerAppearance() {
        self.navigationController?.setToolbarHidden(true, animated: false)

    }
    

    func update() {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        spinner.hidesWhenStopped = true
        
        spinner.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
        API.shared.read { (posts) in
            if let posts = posts {
                self.posts = posts
                self.navigationItem.rightBarButtonItem = nil
            }
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setupGalleryViewControllerAppearance()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as? ImageCollectionViewCell
        cell!.post = self.posts[indexPath.row]
        return cell!
    }

}
