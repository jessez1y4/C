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
    
    @IBAction func SignUpClicked(sender: UIButton) {
        let email = self.emailInput.text
        let name = self.nameInput.text
        let password = self.emailInput.text
        
        if email.isEmpty {
            return Helpers.showSimpleAlert(self, message: "Where is the fucking email?")
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
        
        user.signUpInBackgroundWithBlock { (succeeded: Bool, error: NSError!) -> Void in
            if succeeded {
                // TODO go to homepage
            } else {
                Helpers.showSimpleAlert(self, title: "Attention", message: error.userInfo!["error"] as String)
            }
        }
    }
}

