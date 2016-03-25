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

