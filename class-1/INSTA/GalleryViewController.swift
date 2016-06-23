//
//  GalleryViewController.swift
//  INSTA
//
//  Created by Jess Malesh on 6/22/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import UIKit
import CloudKit

class GalleryViewController: UIViewController, UICollectionViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts = [Post]() {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupGalleryViewController()
        self.setupCollectionView()
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
        
        self.update()
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    func setupGalleryViewController()
    {
        self.navigationItem.title = "Gallery"
    }
    
    func setupCollectionView()
    {
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout()
        
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(GalleryViewController.pinchedCollectionView(_:)))
        self.collectionView.addGestureRecognizer(pinchGesture)
        
    }
    
    func pinchedCollectionView(sender: UIPinchGestureRecognizer)
    {
        let layout = self.collectionView.collectionViewLayout as! GalleryCustomFlowLayout
        var columns = layout.columns
        
        if sender.state == .Ended
        {
            if sender.scale > 1.0
            {
                columns += 1
            }
            else if sender.scale < 1.0
            {
                if columns > 1 {
                    columns -= 1
                }
            }
        }
        
        self.collectionView.setCollectionViewLayout(GalleryCustomFlowLayout(columns: columns), animated: true)
        self.collectionView.collectionViewLayout.invalidateLayout()
        
    }
    
    func update()
    {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
        
        API.shared.GET { (posts) -> () in
            if let posts = posts {
                self.posts = posts
                self.navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        print(self.posts.count)
        return self.posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id()!, forIndexPath: indexPath) as!
        ImageCollectionViewCell
        
        cell.post = self.posts[indexPath.row]
        return cell
    }
}



























