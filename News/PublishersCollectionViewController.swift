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
        
        self.setupViews()
        
        let width = (CGRectGetWidth(collectionView!.frame) - leftAndRightPadding) / numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(width, width + heightAdjustment)
    }
    
    override func viewDidAppear(animated: Bool) {
        let nav = self.navigationController?.navigationBar
        
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.yellowColor()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        
        let image = UIImage(named: "news")
        imageView.image = image
        
        navigationItem.titleView = imageView
        
    }
    
    func setupViews() {
        /*let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
        flowLayout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 50.0)
        
        self.collectionView  = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)*/
        
        self.collectionView!.registerClass(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier:  Storyboard.SectionHeader)
    }
    
    //MARK: - UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return publishers.numberOfSections
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return publishers.numberOfPublishers
        return publishers.numberOfPublishersInSection(section)
    }
    
    private struct Storyboard {
        static let CellIdentifier = "PublisherCell"
        static let ShowWebView = "ShowWebView"
        static let SectionHeader = "SectionHeader"
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier , forIndexPath: indexPath) as! PublisherCollectionViewCell
        
        cell.publisher = publishers.publisherForItemAtIndexPath(indexPath)
        
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        cell.layer.borderColor = UIColor.whiteColor().CGColor
        cell.layer.borderWidth = 3
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: Storyboard.SectionHeader , forIndexPath: indexPath) as? SectionHeaderView
        
        
        
        if sectionHeaderView != nil {
            if let label = publishers.titleForSectionAtIndexPath(indexPath) {
                sectionHeaderView!.titleLabel?.text = label
            }
            return sectionHeaderView!
        } else {
            return UICollectionReusableView(frame: CGRectZero )
        }
        
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
