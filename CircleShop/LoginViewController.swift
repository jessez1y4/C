import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dissmisClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func loginClicked(sender: UIButton) {
        let email = self.emailInput.text
        let password = self.passwordInput.text
        
        if email.isEmpty {
            return Helpers.showSimpleAlert(self, message: "Fill in your fucking email please!")
        }
        
        if password.isEmpty {
            return Helpers.showSimpleAlert(self, message: "Where's the fucking password?")
        }
        
        User.logInWithUsernameInBackground(email, password: password) { (user, error) -> Void in
            
            // TODO also take care of senarios where no internet or parse server down?

            if error != nil {
                return Helpers.showSimpleAlert(self, message: "Invalid email or password.")
            }
     
            let tbc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("my_tab_bar_controller") as MyTabBarController
            
            /* another solution with custom animation
            
            let window = UIApplication.sharedApplication().windows.first as UIWindow
            UIView.transitionWithView(window, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: { () -> Void in
                self.dismissViewControllerAnimated(false, completion: nil)
            window.rootViewController = tbc
            }, completion: nil)

            */
            
            let window = UIApplication.sharedApplication().windows.first as UIWindow
            (window.rootViewController as UINavigationController).pushViewController(tbc, animated: false)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}

