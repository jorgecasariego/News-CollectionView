 //
//  PublishersCollectionViewController.swift
//  News
//
//  Created by Jorge Casariego on 22/2/16.
//  Copyright © 2016 Developer Inspirus. All rights reserved.
//

import UIKit
 
 class PublishersCollectionViewController: UICollectionViewController {
    
    //data source
    let publishers = Publishers()
    
    private let leftAndRightPadding: CGFloat = 32.0
    private let numberOfItemsPerRow: CGFloat = 3.0
    private let heightAdjustment: CGFloat = 30.0
    
    //MARK: - View Controller life cycle
    override func viewDidLoad() {
         super.viewDidLoad()
        
        let width = (CGRectGetWidth(collectionView!.frame) - leftAndRightPadding) / numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(width, width + heightAdjustment)
    }
    
    //MARK: - UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return publishers.numberOfPublishers
    }
    
    private struct Storyboard {
        static let CellIdentifier = "PublisherCell"
        static let ShowWebView = "ShowWebView"
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier , forIndexPath: indexPath) as! PublisherCollectionViewCell
        
        cell.publisher = publishers.publisherForItemAtIndexPath(indexPath)
        
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let publisher = publishers.publisherForItemAtIndexPath(indexPath)
        self.performSegueWithIdentifier(Storyboard.ShowWebView, sender: publisher)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.ShowWebView {
            let webViewController = segue.destinationViewController as! WebViewController
            let publisher = sender as! Publisher
            webViewController.publisher = publisher
        }
    }
 }
