//
//  GalleryViewController.swift
//  INSTGRM
//
//  Created by Sean Champagne on 6/22/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var datasource = [Post]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    class func id() -> String
    {
        return String(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.title = "Gallery"
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.update()
        
//        API.shared.GET { (posts) in
//            if let posts = posts {
//                self.datasource = posts
//            }
//            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupAppearance()
    {
          self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    func setupCollectionView()
    {
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout()
    }
    
    func update()
    {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
    
        API.shared.GET { (posts) in
            if let posts = posts {
                self.datasource = posts
                self.navigationItem.rightBarButtonItem = nil
            }
            }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
        cell.post = self.datasource[indexPath.row]
        return cell
    }

}
