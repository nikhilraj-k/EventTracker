//
//  AddEventsViewController.swift
//  EventsTracking
//
//  Created by Deepish on 13/11/16.
//  Copyright © 2016 Nikhil Raj K. All rights reserved.
//

import UIKit

class AddEventsViewController: UIViewController {
    
    @IBOutlet weak var idTF: UITextField!
    
    @IBOutlet weak var eventNAmeTf: UITextField!
    
    @IBOutlet weak var eventImgTf: UITextField!
    
    @IBOutlet weak var eventPlaceTf: UITextField!
    
    @IBOutlet weak var eventTypeTf: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addEventAction(sender: AnyObject) {
       /* EventUser.deleteAllCoreData("Events") { (error) -> Void in
            if error != nil{
                print(error?.localizedDescription)
            }
            else
            {
                print("coredata deleted  successfully")
            }
        }
        */
        
        EventUser.saveEventData(Int(idTF.text!)!, eventName: eventNAmeTf.text!, eventImg: eventImgTf.text!, eventEntryType:eventTypeTf.text!,eventPlace: eventPlaceTf.text!) { (error) -> Void in
            if error != nil{
                print(error?.localizedDescription)
            }
            else
            {
                print("event data saved successfully")
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
