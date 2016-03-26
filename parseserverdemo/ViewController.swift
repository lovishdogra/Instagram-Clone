//
//  ViewController.swift
//  parseserverdemo
//
//  Created by Lovish Dogra on 25/03/16.
//  Copyright © 2016 Lovish Dogra. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet var usernameText: UITextField!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var alreadyRegLabel: UILabel!
    @IBOutlet var signupBtnOutlet: UIButton!
    @IBOutlet var loginBtnOutlet: UIButton!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var signupActive = true
    
    func displayAlert(title : String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func signupBtn(sender: AnyObject) {
        
        var errorMessage = "Please Try Again Later"
        
        if usernameText.text == "" || passwordText.text == "" {
            
            displayAlert("Error in form", message: "Please enter the Username & Password properly")
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            if signupActive == true {
                
                let user = PFUser()
                
                user.username = usernameText.text
                user.password = passwordText.text
                
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if error == nil {
                        //Signup successful
                        print("signed up")
                        
                    } else {
                        
                        if let errorString = error!.userInfo["error"] as? String {
                            
                            errorMessage = errorString
                        } else {
                            
                            self.displayAlert("Failed Signup", message: errorMessage)
                        }
                    }
                })
            } else {
                
                PFUser.logInWithUsernameInBackground(usernameText.text!, password: passwordText.text!, block: { (user, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if user != nil {
                        
                        //logged in
                        print("logged in")
                        
                    } else {
                        
                        if let errorString = error!.userInfo["error"] as? String {
                            
                            errorMessage = errorString
                        } else {
                            
                            self.displayAlert("Failed login", message: errorMessage)
                        }
                        
                    }
                })
                
            }
        }
    }
    
    @IBAction func loginBtn(sender: AnyObject) {
        
        if signupActive == true {
            
            signupBtnOutlet.setTitle("Login", forState: .Normal)
            alreadyRegLabel.text = "Not registered"
            loginBtnOutlet.setTitle("Signup", forState: .Normal)
            signupActive = false
            
        } else {
            
            signupBtnOutlet.setTitle("Signup", forState: .Normal)
            alreadyRegLabel.text = "Already registered"
            loginBtnOutlet.setTitle("Login", forState: .Normal)
            signupActive = true
            
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        /*
        let product = PFObject(className: "Products")
        product["name"] = "Ice cream"
        product["description"] = "Tutti Fruity"
        product["price"] = 4.99
        
        product.saveInBackgroundWithBlock { (success, error) -> Void in
        if success == true {
        print("Object saved with ID \(product.objectId)")
        } else {
        print("Failed \(error)")
        }
        }
        
        let query = PFQuery(className: "Products")
        query.getObjectInBackgroundWithId("zjbOyAgOLA") { (object, error) -> Void in
        if object != nil {
        print(object!.objectForKey("description")!)
        } else {
        print(error)
        }
        }
        */
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

