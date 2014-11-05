import UIKit

class StartViewController: UIViewController, UIPageViewControllerDataSource {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var pageViewController: UIPageViewController!
    
    let intros = [
        "register with your college email and start trade right away with people you can trust",
        "Share your inventory everywhere using a personal url",
        "ppl can contact you just on the web, without using the app"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("intro_view_controller") as UIPageViewController
        self.pageViewController.dataSource = self
        let firstPage = self.viewControllerAtIndex(0)!
        self.pageViewController.setViewControllers([firstPage], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 70);
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let index = (viewController as IntroContentViewController).index;
        
        if index == 0 {
            return nil;
        }
        
        return self.viewControllerAtIndex(index - 1);
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let index = (viewController as IntroContentViewController).index;
        
        if index == self.intros.count - 1 {
            return nil;
        }
        
        return self.viewControllerAtIndex(index + 1);
    }
    
    
    func viewControllerAtIndex(index: Int) -> IntroContentViewController? {
        if self.intros.count == 0 || index >= self.intros.count {
            return nil
        }
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("intro_content_view_controller") as IntroContentViewController
        
        vc.intro = self.intros[index]
        vc.index = index
        
        /* only show buttons on final page */
        if index == self.intros.count - 1 {
            vc.toggleButtons = { () in
                self.loginBtn.hidden = false
                self.signUpBtn.hidden = false
            }
        } else {
            vc.toggleButtons = { () in
                self.loginBtn.hidden = true
                self.signUpBtn.hidden = true
            }
        }
        
        return vc;
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.intros.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    @IBAction func loginClicked(sender: AnyObject) {
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("login_view_controller") as LoginViewController
        
        self.presentViewController(loginViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func signUpClicked(sender: AnyObject) {
        let signupViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("signup_view_controller") as SignUpViewController
        
        self.presentViewController(signupViewController, animated: true, completion: nil)
        
    }
    
}