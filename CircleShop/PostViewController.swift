import UIKit

class PostViewController: UIViewController, DBCameraViewControllerDelegate {
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var nameInput: UITextField!
    
    var image: UIImage!
    var processImageNumber = 0
    
    var imageViews: [UIImageView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView1.image = image
        
        self.imageViews = [imageView1, imageView2, imageView3, imageView4]
    }
    
    
    @IBAction func tapImageGestureRecognized(sender: AnyObject)
    {
        let tapImage = sender as UITapGestureRecognizer
        let view = tapImage.view! as UIImageView
        
        processImageNumber = find(self.imageViews, view)!;
        handleClick(view)
    }
    
    @IBAction func tapToDismissKeyboard(sender: AnyObject) {
        self.view.endEditing(false)
    }
    
    func handleClick(imageView: UIImageView){
        if imageView.image != nil {
            println("not empty!")
            
            // show the alert and probally delete the image
            self.dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            let cameraController = DBCameraViewController.initWithDelegate(self)
            cameraController.setForceQuadCrop(true)
            
            let container = DBCameraContainerViewController(delegate: self)
            container.setDBCameraViewController(cameraController)
            
            let nav = UINavigationController(rootViewController: container)
            nav.setNavigationBarHidden(true, animated: true)
            self.presentViewController(nav, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func postBtnClicked(sender: AnyObject) {
        
        var itemImages: [PFFile] = []
        
        for imageView in self.imageViews {
            if let image = imageView.image {
                let imageData = UIImageJPEGRepresentation(image, 0.9)
                let imageFile = PFFile(name: "image.jpg", data: imageData)
                
                itemImages.append(imageFile)
            }
        }
        
        let user = User.currentUser()
        let item = Item()
        item.name = self.nameInput.text
        item.images = itemImages
        item.user = user
        item.circle = user.circle
        
        item.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            println("item saved")
            self.performSegueWithIdentifier("post_item_success", sender: self)
        }
    }
    
    func camera(cameraViewController: AnyObject!, didFinishWithImage image: UIImage!, withMetadata metadata: [NSObject : AnyObject]!) {
        
        self.imageViews[processImageNumber].image = image
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dismissCamera(cameraViewController: AnyObject!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
