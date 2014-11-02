//
//  StartViewController.swift
//  CircleShop
//
//  Created by yue zheng on 11/2/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
