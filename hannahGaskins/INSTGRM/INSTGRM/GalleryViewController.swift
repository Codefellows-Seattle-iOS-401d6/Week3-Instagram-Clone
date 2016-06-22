//
//  GalleryVeiwController.swift
//  INSTGRM
//
//  Created by hannah gaskins on 6/22/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var datasource = [Post]() {
        didSet {
            self.collectionView.reloadData()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCollectionView()

        // Do any additional setup after loading the view.
    }
    
    private func setUpCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpAppearance()
        self.update()
    }
    
    func update() {
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        self.navigationController?.setToolbarHidden(true, animated: true) // hides tool bar
        
        API.shared.GET { (posts) in
            if let posts = posts {
                self.datasource = posts
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUpAppearance() {
        self.title = "Gallery"
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
        cell.post = self.datasource[indexPath.row]
        return cell
        
    }
}
