//
//  TrackedEvents.swift
//  EventsTracking
//
//  Created by Nikhil Raj K on 14/11/16.
//  Copyright © 2016 Nikhil Raj K. All rights reserved.
//

import UIKit
import CoreData

class TrackedEvents: NSObject {
    
    var eventId:Int?
    var eventName:String?
    var eventPalce:String?
    var eventImage:String?
    var eventEntry:String?
    
    
    init(eventObject: NSManagedObject) {
        
        
        self.eventId = eventObject.valueForKey("eventId") as? Int
        self.eventName = eventObject.valueForKey("eventName") as? String
        self.eventImage = eventObject.valueForKey("eventImage") as? String
        self.eventPalce = eventObject.valueForKey("eventPlace") as? String
        self.eventEntry = eventObject.valueForKey("eventEntryType") as? String
        
        
    }

    //function for fetching user tracked events based userid
    class func fetchTrackedEventDetails(compPredicateStatus:Bool,entity:String,compPredicate:NSCompoundPredicate?,sinPredicate:NSPredicate?,Sucess:(data:[TrackedEvents]) -> Void)
    {
        
        let appDelegate = getAppdelegate()
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        if (compPredicateStatus) {
            fetchRequest.predicate = compPredicate
        }
        else
        {
            fetchRequest.predicate = sinPredicate
        }
        
        do {
            let result = try managedContext.executeFetchRequest(fetchRequest)
            let data = result as! [NSManagedObject]
           
            var fetchDetails = [TrackedEvents]()
            for item in data
                
            {
                fetchDetails.append(TrackedEvents(eventObject : item))
                
            }
            Sucess(data: fetchDetails)
            
        } catch let error as NSError {
            print("Could not fetch departments from core data(database) ", error.localizedDescription)
            
        }
        
        }
    
    
    //function for track a event
    class func saveTrackedEventData(userId:Int,eventId:Int,eventName:String,eventImg:String,eventEntryType:String,eventPlace:String,failure:(NSError?) -> Void)
    {
        let appDelegate = getAppdelegate()
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("TrackedEvents", inManagedObjectContext: managedContext)
        let attribute = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        attribute.setValue(userId, forKey: "userId")
        attribute.setValue(eventName, forKey: "eventName")
        attribute.setValue(eventId, forKey: "eventId")
        attribute.setValue(eventImg, forKey: "eventImage")
        attribute.setValue(eventEntryType, forKey: "eventEntryType")
        attribute.setValue(eventPlace, forKey: "eventPlace")
        
        
        do {
            try managedContext.save()
            failure(nil)
        } catch let error as NSError {
            print("Could not save ", error, ", ", error.userInfo)
            failure(error)
        }
        
    }
    
    
    //function for untracking event
    class func deleteTrackedEvent(entity: String,predicate:NSCompoundPredicate,failure: NSError? -> Void) {
        let appDelegate = getAppdelegate()
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.predicate = predicate
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            let data = results as! [NSManagedObject]
            
            for fetchedEvent in data {
                managedContext.deleteObject(fetchedEvent )
                
            }
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                print("Could not save ", error, ", ", error.userInfo)
                failure(error)
            }
            
            failure(nil)

            
        } catch let error as NSError {
            print("Delete all data in \(entity) failed with error: \(error.localizedDescription)")
            failure(error)
        }
       
    }
    private class func getAppdelegate() -> AppDelegate
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate
    }
    

}
