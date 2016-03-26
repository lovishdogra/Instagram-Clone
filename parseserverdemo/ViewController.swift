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
    
    @IBAction func signupBtn(sender: AnyObject) {
        
        if usernameText.text == "" || passwordText.text == "" {
            
            let alert = UIAlertController(title: "Error in Data", message: "Please enter properly Username & Password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            let user = PFUser()
            user.username = usernameText.text
            user.password = passwordText.text
            
            user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if error == nil {
                    
                    
                }
            })
            
        }
    }
    
    @IBAction func loginBtn(sender: AnyObject) {
        
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
        */
        
        let query = PFQuery(className: "Products")
        query.getObjectInBackgroundWithId("zjbOyAgOLA") { (object, error) -> Void in
            if object != nil {
                print(object!.objectForKey("description")!)
            } else {
                print(error)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

