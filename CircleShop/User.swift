import Foundation

class User {
    
    var email: String
    
    init(email: String) {
        self.email = email
    }
    
    func signUp() -> Bool {
        // create user on server
        
        return true;
    }
    
    class func login(email: String, password: String, onLoginSuccess: (AFHTTPRequestOperation!, AnyObject!) -> Void, onLoginFailure: (AFHTTPRequestOperation!, AnyObject!) -> Void) {
        
        let manager = AFHTTPRequestOperationManager()
        let parameters = ["email": email, "password": password]
        
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.POST(LOGIN_URL, parameters: parameters, success: onLoginSuccess, failure: onLoginFailure)
        
    }
    
    class func signUp(email: String, name: String, password: String, onSignUpSuccess: (AFHTTPRequestOperation!, AnyObject!) -> Void, onSignUpFailure: (AFHTTPRequestOperation!, AnyObject!) -> Void) {
        
        let manager = AFHTTPRequestOperationManager()
        let parameters = ["email": email, "name": name, "password": password]
        
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.POST(SIGNUP_URL, parameters: parameters, success: onSignUpSuccess, failure: onSignUpFailure)
        
    }
}