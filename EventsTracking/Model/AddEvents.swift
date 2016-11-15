//
//  AddEvents.swift
//  EventsTracking
//
//  Created by Nikhil Raj K on 14/11/16.
//  Copyright © 2016 Nikhil Raj K. All rights reserved.
//

import UIKit
import CoreData

class AddEvents: NSObject {
    
    var eventId:Int?
    var eventName:String?
    var eventPlace:String?
    var eventImage:String?
    var eventEntry:String?
    
    init(eId:Int,eName:String,ePlace:String,eImg:String,eEntry:String)
    {
        self.eventId = eId
        self.eventName = eName
        self.eventImage = eImg
        self.eventPlace = ePlace
        self.eventEntry = eEntry
    }
    
    // function for adding events automatically when coredata gets cleared
    
    class func addEvents()
    {
    
    
    let appDelegate = getAppdelegate()
    let managedContext = appDelegate.managedObjectContext
    let fetchRequest = NSFetchRequest(entityName: "Events")
    do {
    let result = try managedContext.executeFetchRequest(fetchRequest)
    let data = result as! [NSManagedObject]
        
        if data.count == 0
        {
            
            print("no events")
            let dataObj = createEventObjects()
            for item in dataObj
            {
                
                let entity = NSEntityDescription.entityForName("Events", inManagedObjectContext: managedContext)
                let attribute = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                attribute.setValue(item.eventName, forKey: "eventName")
                attribute.setValue(item.eventId, forKey: "eventId")
                attribute.setValue(item.eventImage, forKey: "eventImage")
                attribute.setValue(item.eventEntry, forKey: "eventEntryType")
                attribute.setValue(item.eventPlace, forKey: "eventPlace")
                
                
                do {
                    try managedContext.save()
                    
                } catch let error as NSError {
                    print("Could not save ", error, ", ", error.userInfo)
                   
                }

                
            }
        }
        else
        {
            print("yes events")
        }
        
    
     
    } catch let error as NSError {
    print("Could not fetch departments from core data(database) ", error.localizedDescription)
    
    }
    
    
    }

    private class func createEventObjects() -> [AddEvents]
    
    {
     let obj1 = AddEvents(eId: 1, eName: "Metallica Comcert", ePlace: "Palace Ground", eImg: "one", eEntry: "Paid Entry")
     let obj2 = AddEvents(eId: 2, eName: "Saree Exhibition", ePlace: "Malleswaram Ground", eImg: "two", eEntry: "Free Entry")
     let obj3 = AddEvents(eId: 3, eName: "Wine Tasting", ePlace: "Links Blewery", eImg: "three", eEntry: "Paid Entry")
     let obj4 = AddEvents(eId: 4, eName: "Summernoon Party", ePlace: "Kumara Park", eImg: "four", eEntry: "Paid Entry")
     let obj5 = AddEvents(eId: 5, eName: "Startup Meet", ePlace: "Indoor Stadium", eImg: "five", eEntry: "Paid Entry")
     
    let obj6 = AddEvents(eId: 6, eName: "Rock and Roll Nights", ePlace: "Sarjapur Road", eImg: "six", eEntry: "Paid Entry")

    let obj7 = AddEvents(eId: 7, eName: "Barbique Fridays", ePlace: "WhitwField", eImg:"seven", eEntry: "Paid Entry")

    let obj8 = AddEvents(eId: 8,eName: "Summer Workshop", ePlace: "Indira Nagar", eImg: "eight", eEntry: "Free Entry")
       
    let obj9 = AddEvents(eId: 9, eName: "Impressions & Expressions", ePlace: "MG Road", eImg: "nine", eEntry: "Free Entry")
        
    let obj10 = AddEvents(eId: 10, eName: "Italian Carnival", ePlace: "Electronic City", eImg: "ten", eEntry: "Paid Entry")

     var sampleData = [AddEvents]()
        
     sampleData += [obj1,obj2,obj3,obj4,obj5,obj6,obj7,obj8,obj9,obj10]
    return sampleData
    }
    private class func getAppdelegate() -> AppDelegate
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate
    }

}
