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
        if self.emailInput.text.isEmpty || self.passwordInput.text.isEmpty {
            Helpers.showSimpleAlert(self, message: "Please enter Email and Password.")
        } else {
            User.signUp(self.emailInput.text, name: self.nameInput.text, password: self.passwordInput.text, onSignUpSuccess: onSignUpSuccess, onSignUpFailure: onSignUpFailure)
        }
    }
    
    func onSignUpSuccess(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) {
        // create current user
        
        // show homepage
        self.performSegueWithIdentifier("signUpSuccess", sender: self)
    }
    
    func onSignUpFailure(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) {
        // alert failure
        Helpers.showSimpleAlert(self, message: "Fail.")
    }
}

