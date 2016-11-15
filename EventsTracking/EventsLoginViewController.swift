//
//  EventsLoginViewController.swift
//  EventsTracking
//
//  Created by Nikhllraj on 13/11/16.
//  Copyright © 2016 Nikhil Raj K. All rights reserved.
//

import UIKit

class EventsLoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    AddEvents.addEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueAction(sender: AnyObject) {
     
        guard userNameTF.text?.characters.count >= 4 else{
            print("username should be four characers or more")
            let loginAlert = UIAlertController(title: "", message: "Username should be four characters", preferredStyle: UIAlertControllerStyle.Alert)
            
            loginAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
               
                }))
            
            presentViewController(loginAlert, animated: true, completion: nil)

            return
            }

       EventUser.saveUserData(userNameTF.text!, entity: "User") {[weak self] (error) -> Void in
        if error != nil
        {
            print(error)
        }else
        {
            print("no error please continue")
            self?.userNameTF.text = ""
            self!.performSegueWithIdentifier("goToHome", sender: nil)
        }
        }
        
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
