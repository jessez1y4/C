import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SignUpClicked(sender: UIButton) {
        let email = self.emailInput.text
        let name = self.nameInput.text
        let password = self.passwordInput.text
        
        if email.isEmpty {
            return Helpers.showSimpleAlert(self, message: "Where is the fucking email?")
        }
        
        if !email.hasSuffix(".edu") {
            return Helpers.showSimpleAlert(self, message: ".edu please")
        }
        
        if password.isEmpty {
            return Helpers.showSimpleAlert(self, message: "Where is the fucking password??")
        }
        
        if name.isEmpty {
            return Helpers.showSimpleAlert(self, message: "where is the fucking name?")
        }
        
        let user = PFUser()
        user.email = email
        user.username = email // use email as username
        user.password = password
        user["name"] = name
        
        user.signUpInBackgroundWithBlock { (succeeded, error) -> Void in
            if succeeded {
                PFUser.logInWithUsernameInBackground(user.email, password: user.password, block: nil)
 
                let tbc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("my_tab_bar_controller") as MyTabBarController
                
                // self.navigationController?.pushViewController(tbc, animated: true)
                
                let window = UIApplication.sharedApplication().windows.first as UIWindow
                UIView.transitionWithView(window, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: { () -> Void in
                    window.rootViewController = tbc
                    }, completion: nil)
            } else {
                println(error)
                Helpers.showSimpleAlert(self, title: "Attention", message: error.userInfo!["error"] as String)
            }
        }
    }
}

