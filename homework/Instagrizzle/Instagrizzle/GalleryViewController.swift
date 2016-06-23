//
//  GalleryViewController.swift
//  Instagrizzle
//
//  Created by Sung Kim on 6/22/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private var posts = [Post]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.setupAppearance()
        self.update()
    }
    
    class func id() -> String {
        return String(self)
    }
    
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout()
    }
    
    private func setupAppearance() {
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    private func update() {
        self.indicatorView.startAnimating()

        API.shared.GET { (posts) in
            if let posts = posts {
                self.posts = posts
                self.indicatorView.stopAnimating()
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
        cell.post = self.posts[indexPath.row]
        return cell
    }
}