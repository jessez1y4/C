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
        User.signUp(self.emailInput.text, name: self.nameInput.text, password: self.passwordInput.text, callback: signUpCallback)
    }
    
    func signUpCallback(error: String?) {
        
        if let err = error {
            return Helpers.showSimpleAlert(self, message: err)
        }
        

        // todo: show homepage
        println("user signed up and logged in")
    }
    
}

