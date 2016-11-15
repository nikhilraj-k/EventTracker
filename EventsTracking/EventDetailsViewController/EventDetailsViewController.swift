//
//  EventDetailsViewController.swift
//  EventsTracking
//
//  Created by Nikhil Raj K on 14/11/16.
//  Copyright © 2016 Nikhil Raj K. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
   
    var detailEvent:EventDatas?
    var detailTrackEvent:TrackedEvents?
    var eventStatus:Bool = true
    
    @IBOutlet weak var eventDetailName: UILabel!
    
    @IBOutlet weak var eventDetailPlace: UILabel!
    
    @IBOutlet weak var eventDetailImage: UIImageView!
    
    @IBOutlet weak var eventDetailEntry: UILabel!
    
    @IBOutlet weak var eventDetailTrackBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("userId") as? Int
        print("my user id is = \(userId)")

        // Do any additional setup after loading the view.
        checkEventType()
        
        
            }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Event Details"
        self.navigationController?.navigationBar.topItem?.title = ""
        
    }

    
    //function for checking event details from tracked or normal events
    

    func checkEventType()
    {
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("userId") as? Int
        // Do any additional setup after loading the view.
        if(eventStatus)
        {
         
            if let detailEvents = detailEvent
            {
                
                if let eName = detailEvents.eventName,let eImg = detailEvents.eventImage,let ePlace = detailEvents.eventPalce,let eEntry = detailEvents.eventEntry,let eventId = detailEvents.eventId
                {
                    setEntryLabelColor(eEntry)
                    self.eventDetailName.text = eName
                    self.eventDetailPlace.text = ePlace
                    self.eventDetailEntry.text = eEntry
                    self.eventDetailImage.image = UIImage(named:eImg)
                    checkTrackStatus(userId!, eventId: eventId)
                }
                
            }

        }
       else{
            if let detailEvents = detailTrackEvent
            {
                
                if let eName = detailEvents.eventName,let eImg = detailEvents.eventImage,let ePlace = detailEvents.eventPalce,let eEntry = detailEvents.eventEntry,let eventId = detailEvents.eventId
                {
                    setEntryLabelColor(eEntry)
                    self.eventDetailName.text = eName
                    self.eventDetailPlace.text = ePlace
                    self.eventDetailEntry.text = eEntry
                    self.eventDetailImage.image = UIImage(named:eImg)
                    
                    checkTrackStatus(userId!, eventId: eventId)
                }
                
            }

            
        }
        
    }
    
    
    func setEntryLabelColor(entryType:String)
    {
        if entryType == "Paid Entry"
        {
            self.eventDetailEntry.textColor = UIColor.redColor()
        }
        else{
            self.eventDetailEntry.textColor = UIColor.greenColor()
        }
        }
    
    func checkTrackStatus(userId:Int,eventId:Int)
    {
        let predicate2 = NSPredicate(format: "eventId == %d",eventId)
   
        let predicate1 = NSPredicate(format: "userId == %d",userId)
      
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1,predicate2])
        
        TrackedEvents.fetchTrackedEventDetails(true, entity: "TrackedEvents", compPredicate: compound, sinPredicate: nil) {[weak self] (data) in
          
            if data.count != 0
            {
                 print(data[0].eventEntry)
                self!.eventDetailTrackBtn.setTitle("Untrack", forState: UIControlState.Normal)
            }
            else{
                self!.eventDetailTrackBtn.setTitle("Track", forState: UIControlState.Normal)
            }
           
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //function for delete tracked event from coredata based on eventid and userid
    func untrackEvent(userId:Int,eventId:Int)
    {
        
        let predicate2 = NSPredicate(format: "eventId == %d",eventId)
        
        let predicate1 = NSPredicate(format: "userId == %d",userId)
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1,predicate2])
        TrackedEvents.deleteTrackedEvent("TrackedEvents", predicate: compound, failure: { [weak self](error) in
            if error != nil
            {
                print(error?.localizedDescription)
            }
            else
            {
                self!.eventDetailTrackBtn.setTitle("Track", forState: UIControlState.Normal)
                
            }
            
        })

    }
    
    
    @IBAction func trackAction(sender: AnyObject) {
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("userId") as? Int
        if let detailEvents = detailEvent
        {
            if let eName = detailEvents.eventName,let eImg = detailEvents.eventImage,let ePlace = detailEvents.eventPalce,let eEntry = detailEvents.eventEntry,let eventId = detailEvents.eventId
            {
                if self.eventDetailTrackBtn.titleLabel?.text == "Track"{
                TrackedEvents.saveTrackedEventData(userId!, eventId: eventId, eventName: eName, eventImg: eImg, eventEntryType: eEntry, eventPlace: ePlace, failure: {[weak self] (error) in
                
                    if error != nil
                    {
                        print(error?.localizedDescription)
                    }
                    else
                    {
                        print("no error")
                    self!.eventDetailTrackBtn.setTitle("Untrack", forState: UIControlState.Normal)
                    }
                    
                })
                }
                else{
                   
                    untrackEvent(userId!, eventId: eventId)
                }

            }

        }
        // delete events from tracked event page
        else
        {
            if let detailEvents = detailTrackEvent
            {
            if let eventId = detailEvents.eventId
            {
                untrackEvent(userId!, eventId: eventId)
            }
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
