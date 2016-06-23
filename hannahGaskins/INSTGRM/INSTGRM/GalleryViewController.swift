//
//  GalleryVeiwController.swift
//  INSTGRM
//
//  Created by hannah gaskins on 6/22/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var datasource = [Post]() {
        didSet {
            self.collectionView.reloadData()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCollectionView()
    }
    
    func setUpCollectionView() {
        
        // Adding Pinch Gesture Programmatically
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(GalleryViewController.pinchedCollectionView(_:)))
        // add pinch gesture to collection view
        self.collectionView.addGestureRecognizer(pinchGesture)
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout(columns: 3)
        
        // these two lines may be unnecessary!!!!!!!!!!!!!!!!!!!!!!!!
        
//        self.collectionView.dataSource = self
//        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout()
    }

    
    // making funciton here:
    
    func pinchedCollectionView(sender: UIPinchGestureRecognizer) {
        let layout = self.collectionView.collectionViewLayout as! GalleryCustomFlowLayout// casting as type and force unwraping
        var columns = layout.columns
        // handling the state, switching on the state of the pinch
        if sender.state == .Ended {
            if sender.scale > 1.0 {
                columns += 1
            }
            else if sender.scale < 1.0 {
                if columns > 1 {
                    columns -= 1
                }
            }
        }
        // reassigning
        self.collectionView.setCollectionViewLayout(GalleryCustomFlowLayout(columns: columns), animated: true)
        // now we need to invalidate
        self.collectionView.collectionViewLayout.invalidateLayout()
    }

    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpAppearance()
        self.update()
    }
    
    func update() {
        
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        self.navigationController?.setToolbarHidden(true, animated: true) // hides tool bar
        
        API.shared.GET { (posts) in
            if let posts = posts {
                self.datasource = posts
                self.spinner.stopAnimating()
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
    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.datasource.count
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
//        cell.post = self.datasource[indexPath.row]
//        return cell
//    }
    
    // replacement code as of 6.23
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
        cell.post = self.datasource[indexPath.row]
        return cell
        
    }

}
