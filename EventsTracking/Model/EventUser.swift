//
//  EventUser.swift
//  EventsTracking
//
//  Created by Deepish on 13/11/16.
//  Copyright © 2016 Nikhil Raj K. All rights reserved.
//

import UIKit
import CoreData

class EventUser: NSObject {
    
    //class function for saving user data
    
    class func saveUserData(userName:String,entity:String,failure:(NSError?) -> Void)
    {
      
            let appDelegate = getAppdelegate()
            let managedContext = appDelegate.managedObjectContext
            let fetchRequest = NSFetchRequest(entityName: entity)
            let predicate = NSPredicate(format: "userName == %@",userName)
             fetchRequest.predicate = predicate
            //fetching user data for checking user is already exist
            do {
                let result = try managedContext.executeFetchRequest(fetchRequest)
                let managedData = result as! [NSManagedObject]
                print(managedData.count)
                if(managedData.count == 0)
                {
                     let fetchID = NSFetchRequest(entityName: entity)
                    
                    do {
                        let idResult = try managedContext.executeFetchRequest(fetchID)
                        let idData = idResult as! [NSManagedObject]
                        let uId = idData.count+1
                        //calling save function to save new user
                        saveUser(userName, id: uId)
                        
                         NSUserDefaults.standardUserDefaults().setObject(uId, forKey: "userId")
                          NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")
                         NSUserDefaults.standardUserDefaults().setObject("None", forKey: "sortType")
                        print("my new userId = \(uId)")
                        
                     
                    } catch let error as NSError {
                        print("Could not fetch departments from core data(database) ", error.localizedDescription)
                        failure(error)
                    }
                  }
                //condition for already existing user
                else
                {
                    print("user already exist no need to save")
                    
                 let userId = managedData[0].valueForKey("userId")
                     let savedUser = managedData[0].valueForKey("userName")
                      let sortType = managedData[0].valueForKey("sortType")
                    print(sortType)
                    NSUserDefaults.standardUserDefaults().setObject(userId, forKey: "userId")
                      NSUserDefaults.standardUserDefaults().setObject(savedUser, forKey: "userName")
                    print("my already existing user Id = \(userId)")
                     NSUserDefaults.standardUserDefaults().setObject(sortType, forKey: "sortType")
                  

                    
                }
                failure(nil)
            } catch let error as NSError {
                print("Could not fetch departments from core data(database) ", error.localizedDescription)
                failure(error)
            }
        

    }
    
    private class func saveUser(name:String,id:Int)
    {
            let appDelegate = getAppdelegate()
            let managedContext = appDelegate.managedObjectContext
        
            let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
            let attribute = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
     
            let sort = "None"
        
            attribute.setValue(name, forKey: "userName")
            attribute.setValue(id, forKey: "userId")
            attribute.setValue(sort, forKey: "sortType")
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save ", error, ", ", error.userInfo)
            }
        }
    

    class func saveEventData(eventId:Int,eventName:String,eventImg:String,eventEntryType:String,eventPlace:String,failure:(NSError?) -> Void)
    {
        let appDelegate = getAppdelegate()
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Events", inManagedObjectContext: managedContext)
        let attribute = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
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
    
    class func deleteAllCoreData(entity: String, failure: NSError? -> Void) {
        let appDelegate = getAppdelegate()
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            results.forEach {
                let managedObjectData = $0 as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
                failure(nil)
            }
            
        } catch let error as NSError {
            print("Delete all data in \(entity) failed with error: \(error.localizedDescription)")
            failure(error)
        }
    }
    
    //update function for user sort type

    class func updateUser(predicate:NSPredicate,sortType:String)
    {
        
        let appDelegate = getAppdelegate()
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = predicate
        
        
        do {
            //let fetchedEntities = try managedContext.executeFetchRequest(fetchRequest)
            let result = try managedContext.executeFetchRequest(fetchRequest)
            let data = result as! [NSManagedObject]
            data[0].setValue(sortType, forKey: "sortType")
            print("my sort type ==== \(sortType)")
           try managedContext.save()
           

            
            //fetchedEntities.first?.SecondPropertyToUpdate = NewValue
            // ... Update additional properties with new values
        } catch {
            // Do something in response to error condition
        }
        
       }
    private class func getAppdelegate() -> AppDelegate
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate
    }

}
