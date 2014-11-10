//
//  ViewController.swift
//  PinterestSwift
//
//  Created by Nicholas Tau on 6/30/14.
//  Copyright (c) 2014 Nicholas Tau. All rights reserved.
//

import UIKit

let waterfallViewCellIdentify = "waterfallViewCellIdentify"

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate{
    func navigationController(navigationController: UINavigationController!, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController!, toViewController toVC: UIViewController!) -> UIViewControllerAnimatedTransitioning!{
        let transition = NTTransition()
        transition.presenting = operation == .Pop
        return  transition
    }
}

class NTWaterfallViewController:UICollectionViewController,CHTCollectionViewDelegateWaterfallLayout, NTTransitionProtocol, NTWaterFallViewControllerProtocol{

    let delegateHolder = NavigationControllerDelegate()
    
    // circle
    var circle: Circle!
    var items: [Item] = []
    var page = 0
    let per = 10
    var placeholder = UIImage(named: "bicon.png")
    var fetching = false
    var startContentOffset: CGFloat = 0
    var lastContentOffset: CGFloat = 0
    var hidden: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController!.delegate = delegateHolder
        self.view.backgroundColor = UIColor.yellowColor()
        collectionView.frame = screenBounds
        collectionView.setCollectionViewLayout(CHTCollectionViewWaterfallLayout(), animated: false)
        collectionView.backgroundColor = UIColor.grayColor()
        collectionView.registerClass(NTWaterfallViewCell.self, forCellWithReuseIdentifier: waterfallViewCellIdentify)
        hidden = false
        
        // circle
        self.circle = User.currentUser().circle
        var logoImage = UIImage(named: "bicon.png")
        var backCircleImage = UIImage(named: "light_circle.png")
        var frontCircleImage = UIImage(named: "dark_circle.png")
        var progressView = BMYCircularProgressView(frame: CGRectMake(0, 0, 25, 25), logo: logoImage, backCircleImage: backCircleImage, frontCircleImage: frontCircleImage)
        
        self.collectionView.setPullToRefreshWithHeight(10, actionHandler: { (pullToRefreshView: BMYPullToRefreshView!) -> Void in
            
            self.page = self.circle.getItems(0, per: self.per, callback: { (results, error) -> Void in
                if error == nil {
                    let items = results as [Item]
                    if items.first?.objectId != self.items.first?.objectId {
                        self.items = results as [Item]
                        self.collectionView.reloadData()
                    }
                }
                pullToRefreshView.stopAnimating()
            })
        })
        
        collectionView.pullToRefreshView.preserveContentInset = true
        collectionView.pullToRefreshView.setProgressView(progressView)
    
        self.page = self.circle.getItems(0, per: self.per, callback: { (results, error) -> Void in
            if error == nil {
                self.items = results as [Item]
                self.collectionView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.view.addGestureRecognizer(self.slidingViewController().panGesture)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(gridWidth, gridWidth)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        var collectionCell: NTWaterfallViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(waterfallViewCellIdentify, forIndexPath: indexPath) as NTWaterfallViewCell
        
        // circle
        collectionCell.imageFile = self.items[indexPath.row].images.first
        collectionCell.setNeedsLayout()
        return collectionCell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.items.count
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let pageViewController =
        NTHorizontalPageViewController(collectionViewLayout: pageViewControllerLayout(), currentIndexPath:indexPath)
        
        // circle
        pageViewController.items = self.items
        collectionView.setCurrentIndexPath(indexPath)
        
        navigationController!.pushViewController(pageViewController, animated: true)
    }
    
    func pageViewControllerLayout () -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let itemSize  = self.navigationController!.navigationBarHidden ?
        CGSizeMake(screenWidth, screenHeight+20) : CGSizeMake(screenWidth, screenHeight-navigationHeaderAndStatusbarHeight)
        flowLayout.itemSize = itemSize
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .Horizontal
        return flowLayout
    }
    
    func viewWillAppearWithPageIndex(pageIndex : NSInteger) {
        var position : UICollectionViewScrollPosition =
        .CenteredHorizontally & .CenteredVertically
//        let image:UIImage! = UIImage(named: self.imageNameList[pageIndex] as NSString)
//        let imageHeight = image.size.height*gridWidth/image.size.width
        let imageHeight = gridWidth
        if imageHeight > 400 {//whatever you like, it's the max value for height of image
           position = .Top
        }
        let currentIndexPath = NSIndexPath(forRow: pageIndex, inSection: 0)
        collectionView.setCurrentIndexPath(currentIndexPath)
        if pageIndex<2{
            collectionView.setContentOffset(CGPointZero, animated: false)
        }else{
            collectionView.scrollToItemAtIndexPath(currentIndexPath, atScrollPosition: position, animated: false)
        }
    }
    
    func transitionCollectionView() -> UICollectionView!{
        return collectionView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
        startContentOffset = scrollView.contentOffset.y

    }
    

    @IBAction func menuClicked(sender: AnyObject) {
        self.slidingViewController().anchorTopViewToRightAnimated(true)
    }

}

