import Foundation

class User {
    
    class func login(email: String, password: String, callback: (error: String?) -> Void) {
        
        if email.isEmpty {
            return callback(error: "Email cannot be empty.")
        }
        
        if password.isEmpty {
            return callback(error: "Password cannot be empty")
        }
        
        
        let parameters = ["email": email, "password": password]
        
        Helpers.AFManager().POST(LOGIN_URL, parameters: parameters, success: makeOnLoginSuccess(callback, parameters: parameters), failure: makeOnLoginFailure(callback))
    }
    
    
    class func getCurrentUser() -> [String: AnyObject]? {
        
        return NSUserDefaults.standardUserDefaults().objectForKey(NSUSERDEFAULTS_CURRENTUSER_KEY) as? [String: AnyObject]
    }
    
    
    class func signUp(email: String, name: String, password: String, callback: (error: String?) -> Void) {
        
        if email.isEmpty {
            return callback(error: "Email cannot be empty.")
        }
        
        if password.isEmpty {
            return callback(error: "Password cannot be empty")
        }
        
        if name.isEmpty {
            return callback(error: "Name cannot be empty.")
        }
        
        let parameters = ["email": email, "name": name, "password": password]
        
        Helpers.AFManager().POST(SIGNUP_URL, parameters: parameters, success: makeOnSignUpSuccess(callback), failure: makeOnSignUpFailure(callback))
        
    }
    
    
    class func isLoggedIn() -> Bool {
        return NSUserDefaults.standardUserDefaults().objectForKey("email") == nil
    }
    
    
    
    
    
    
    // private functions
    
    private class func makeOnLoginSuccess(callback: (error: String?) -> Void, parameters: [String: String]) -> ((AFHTTPRequestOperation!, AnyObject!) -> Void) {
        
        func onLoginSuccess(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) {
            
            self.saveUserCredential(parameters["email"]!, password: parameters["password"]!)
            self.setCurrentUser(responseObject as [String: AnyObject])
            callback(error: nil)
        }
        
        return onLoginSuccess
    }
    
    
    private class func makeOnLoginFailure(callback: (error: String?) -> Void) -> ((AFHTTPRequestOperation!, AnyObject!) -> Void) {
        
        func onLoginFailure(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) {
            
            if let response = operation.response {
                if response.statusCode == 401 {
                    return callback(error: "Invalid email or password")
                }
            }
            
            callback(error: "Something went wrong. Please try again.")
        }
        
        return onLoginFailure
    }
    
    
    private class func setCurrentUser(user: [String: AnyObject]) {
        let standardUserDefaults = NSUserDefaults.standardUserDefaults()
        
        standardUserDefaults.setObject(user["email"], forKey: "email")
        standardUserDefaults.setObject(user["circles"], forKey: "circles")
    }
    
    
    private class func saveUserCredential(email: String, password: String) {
        SSKeychain.setPassword(password, forService: KEYCHAIN_SERVICE, account: email)
    }

    
    private class func makeOnSignUpSuccess(callback: (error: String?) -> Void) -> ((AFHTTPRequestOperation!, AnyObject!) -> Void) {
        
        func onSignUpSuccess(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) {
            
            self.setCurrentUser(responseObject as [String: AnyObject])
            callback(error: nil)
        }
        
        return onSignUpSuccess
    }
    
    
    private class func makeOnSignUpFailure(callback: (error: String?) -> Void) -> ((AFHTTPRequestOperation!, AnyObject!) -> Void) {
        
        func onSignUpFailure(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) {
            
            let res = operation.responseObject as [String: AnyObject]
            let errMsg = res["error"] as AnyObject? as? String ?? "Something went wrong. Please try again."
            
            callback(error: errMsg)
        }
        
        return onSignUpFailure
    }


}