import UIKit

class IntroContentViewController: UIViewController {

    @IBOutlet weak var introLabel: UILabel!
    
    var intro: String!
    var index: Int!
    var toggleButtons: (() -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.introLabel.text = self.intro
    }

    override func viewDidAppear(animated: Bool) {
        self.toggleButtons()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
