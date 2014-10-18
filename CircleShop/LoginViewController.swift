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
        User.login(self.emailInput.text, password: self.passwordInput.text, callback: loginCallback)
    }
    
    func loginCallback(error: String?) {
        
        // alert error message if any
        if let err = error {
            return Helpers.showSimpleAlert(self, message: err)
        }
        
        // show homepage if no error message (meaning login success)
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
}

