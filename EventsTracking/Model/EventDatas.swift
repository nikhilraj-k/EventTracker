//
//  EventDatas.swift
//  EventsTracking
//
//  Created by Nikhil Raj K on 13/11/16.
//  Copyright © 2016 Nikhil Raj K. All rights reserved.
//

import UIKit
import CoreData

class EventDatas: NSObject {
    
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
    //fetching eventdata from entity events

    class func fetchEventDetails(sortType:String,entity:String,Sucess:(data:[EventDatas]) -> Void)
    {
        
        let appDelegate = getAppdelegate()
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        if sortType == "Asc"
        {
            let sortDescriptor = NSSortDescriptor(key: "eventName", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
        }
        if sortType == "Dsc"
        {
            let sortDescriptor = NSSortDescriptor(key: "eventName", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
        }
        
        do {
            let result = try managedContext.executeFetchRequest(fetchRequest)
            let data = result as! [NSManagedObject]
            
            var fetchDetails = [EventDatas]()
            for item in data

            {
                fetchDetails.append(EventDatas(eventObject : item))
            }
        Sucess(data: fetchDetails)
            
                 } catch let error as NSError {
            print("Could not fetch departments from core data(database) ", error.localizedDescription)
        
        }

        
    }
    private class func getAppdelegate() -> AppDelegate
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate
    }
    
  
}
