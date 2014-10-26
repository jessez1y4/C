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
        let email = self.emailInput.text
        let password = self.passwordInput.text
        
        if email.isEmpty {
            return Helpers.showSimpleAlert(self, message: "Fill in your fucking email please!")
        }
        
        if password.isEmpty {
            return Helpers.showSimpleAlert(self, message: "Where's the fucking password?")
        }
        
        PFUser.logInWithUsernameInBackground(email, password: password) { (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                Helpers.showSimpleAlert(self, message: "Invalid email or password.")
                
                // TODO also take care of senarios where no internet or parse server down?
            }
        }
    }
}

