import UIKit

class CircleCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var circle = User.currentUser().circle
    var items: [Item] = []
    var page = 0
    let per = 10
    var placeholder = UIImage(named: "bicon.png")
    var fetching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var logoImage = UIImage(named: "bicon.png")
        var backCircleImage = UIImage(named: "light_circle.png")
        var frontCircleImage = UIImage(named: "dark_circle.png")
        
        var progressView = BMYCircularProgressView(frame: CGRectMake(0, 0, 25, 25), logo: logoImage, backCircleImage: backCircleImage, frontCircleImage: frontCircleImage)
        
        self.collectionView.setPullToRefreshWithHeight(10, actionHandler: { (pullToRefreshView: BMYPullToRefreshView!) -> Void in

            self.page = self.circle.getItems(0, per: self.per, callback: { (items, error) -> Void in
                if error == nil {
                    if items.first?.objectId != self.items.first?.objectId {
                        self.items = items
                        self.collectionView.reloadData()
                    }
                }
                
                pullToRefreshView.stopAnimating()
            })
        })
        
        self.collectionView.pullToRefreshView.preserveContentInset = true
        self.collectionView.pullToRefreshView.setProgressView(progressView)
        
        self.page = self.circle.getItems(0, per: self.per, callback: { (items, error) -> Void in
            if error == nil {
                self.items = items
                self.collectionView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "show_detail") {
            let destViewController = segue.destinationViewController as DetailViewController
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("CircleCollectionCell", forIndexPath: indexPath) as CircleCollectionViewCell
        let item = self.items[indexPath.row]

        cell.imageView.image = self.placeholder
        cell.imageView.file = item.images.first
        cell.imageView.loadInBackground(nil)
        
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.items.count < self.per || self.fetching {
            return
        }
        
        for path in self.collectionView.indexPathsForVisibleItems() as [NSIndexPath] {
            if  path.row == self.items.count - 1 {
                self.fetching = true
                self.page = self.circle.getItems(self.page, per: self.per, callback: { (items, error) -> Void in
                    if error == nil {
                        self.items = self.items + items
                        self.collectionView.reloadData()
                        self.fetching = false
                    }
                    
                })
            }
        }
    }

}
