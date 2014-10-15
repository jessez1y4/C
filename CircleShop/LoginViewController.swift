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
    
    @IBAction func loginClicked(sender: UIButton) {
        if self.emailInput.text.isEmpty || self.passwordInput.text.isEmpty {
            Helpers.showSimpleAlert(self, message: "Please enter Email and Password.")
        } else {
            User.login(self.emailInput.text, password: self.passwordInput.text, onLoginSuccess: onLoginSuccess, onLoginFailure: onLoginFailure)
        }
    }
    
    func onLoginSuccess(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) {
        // create current user
        
        // show homepage
//        self.performSegueWithIdentifier("loginSuccess", sender: self)
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func onLoginFailure(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) {
        // alert failure
        Helpers.showSimpleAlert(self, message: "Fail.")
    }
    
}

