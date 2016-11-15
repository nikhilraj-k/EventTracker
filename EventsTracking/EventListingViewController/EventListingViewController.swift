//
//  EventListingViewController.swift
//  EventsTracking
//
//  Created by Nikhil Raj K on 12/11/16.
//  Copyright © 2016 Nikhil Raj K. All rights reserved.
//

import UIKit

class EventListingViewController: UIViewController {
    
    //connecting outlets
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    
    @IBOutlet weak var viewTypeImageView: UIImageView!
  
    @IBOutlet weak var viewTypeView: UIView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var sortImgView: UIImageView!
    
    
    var newEventsData = [EventDatas]()
    var passEventDetails:EventDatas?
    //Declaring vaqriables
    var isListViewStatus:Bool = true
    var sortType:String?
    
    //instance of collectionview layouts
     var listViewLayOut = ListCollectionViewFlowLayout()
     var gridViewLayout = GridCollectionViewLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //setting username
        if let userName = NSUserDefaults.standardUserDefaults().valueForKey("userName") as? String
        {
            self.userNameLabel.text = userName
        }
        
        //setting sort imageview based on the current sort
        setSortImages()
        
        sortType = NSUserDefaults.standardUserDefaults().valueForKey("sortType") as? String
        
        setupInitialLayout()
        registerNibs()
        
        // tap gesture for handing list and grid view
        let changeViewGesture =  UITapGestureRecognizer(target: self, action: "listAndGridTapped")
        viewTypeView.userInteractionEnabled = true
        viewTypeView.addGestureRecognizer(changeViewGesture)
      
        //fetch data from events to populate collectionview
        EventDatas.fetchEventDetails(sortType!,entity: "Events") { (data) -> Void in
             self.newEventsData = data
            
        }

       //swipe gesture for showing user tapped actions
        //let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action:("handleSwipes:"))
        
        leftSwipe.direction = .Left
        view.addGestureRecognizer(leftSwipe)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "My Events"
        self.navigationController?.navigationBar.topItem?.title = ""

    }
    
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        
        
         performSegueWithIdentifier("showTrackedEvents", sender: nil)
    }
    
    func setSortImages()
    {
        if let sortType = NSUserDefaults.standardUserDefaults().valueForKey("sortType") as? String
        {
            if sortType == "Asc"
            {
                self.sortImgView.image = UIImage(named: "asc")
            }
            else if sortType == "Dsc"
            {
                self.sortImgView.image = UIImage(named: "dsc")
            }
            else
            {
                self.sortImgView.image = UIImage(named: "sort1")
            }
        }
    }
    
    
    func listAndGridTapped()
    {
        setButtonStatus()
        if(isListViewStatus)
        {
            self.eventsCollectionView.reloadData()
            self.eventsCollectionView.collectionViewLayout.invalidateLayout()
            UIView.animateWithDuration(0.2, animations: {}) { (finish) in
                
                if(finish)
                    
                {
                    self.eventsCollectionView.collectionViewLayout = self.gridViewLayout
                    self.eventsCollectionView.reloadData()
                    
                }
            }

            isListViewStatus = false

        }
        else{
            self.eventsCollectionView.reloadData()
            self.eventsCollectionView.collectionViewLayout.invalidateLayout()
            
            UIView.animateWithDuration(0.2, animations: {}) { (finish) in
                
                if(finish)
                {
                    self.eventsCollectionView.collectionViewLayout = self.listViewLayOut
                    self.eventsCollectionView.reloadData()
                    
                }
            }

            
            isListViewStatus = true
            
            }
        
    }
        

    
    //setting initial layout of a collection view
    func setupInitialLayout() {
        isListViewStatus = true
        eventsCollectionView.backgroundColor = UIColor.lightGrayColor()
        eventsCollectionView.collectionViewLayout = listViewLayOut
    }
    
    // registering nibs of collection view
    func registerNibs()
    {
        self.eventsCollectionView.registerNib(UINib(nibName: "EvenetsListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listIdentifier")
        self.eventsCollectionView.registerNib(UINib(nibName: "EventsGridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "gridIdentifier")
    
    }
    //setting image of list and grid imageview
    func setButtonStatus()
    {
        if (isListViewStatus)
        {
            self.viewTypeImageView .image = UIImage(named: "grid")
                   }
        else
        {
            self.viewTypeImageView .image = UIImage(named: "list")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newEventsData.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
         let obj = newEventsData[indexPath.row]
        if (isListViewStatus){
            
            let cell :EvenetsListCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("listIdentifier", forIndexPath: indexPath) as!
            EvenetsListCollectionViewCell
           
            cell.EventNameLabel.font = UIFont.systemFontOfSize(18)
            cell.eventPlaceLabel.font = UIFont.systemFontOfSize(16)
            cell.eventEntryLabel.font = UIFont.systemFontOfSize(14)
            if let img = obj.eventImage
            {
                cell.eventListImgView.image = UIImage(named: img)
            }
            
            if let eName = obj.eventName
            {
                cell.EventNameLabel.text = eName
            }
            if let ePlace = obj.eventPalce
            {
                cell.eventPlaceLabel.text = ePlace
            }
            if let eEntry = obj.eventEntry
            {
                if eEntry == "Paid Entry"{
                    cell.eventEntryLabel.textColor = UIColor.redColor()
                }else{
                    cell.eventEntryLabel.textColor = UIColor.greenColor()
                }
                cell.eventEntryLabel.text = eEntry
            }
            return cell
        }
            
        else
        {
            let cell :EventsGridCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("gridIdentifier", forIndexPath: indexPath) as! EventsGridCollectionViewCell
            
            if let img = obj.eventImage
            {
                cell.gridEventImage.image = UIImage(named: img)
            }
            if let eName = obj.eventName
            {
            
               cell.gridEventNameLabel.text = eName
            }
            return cell
            
        }
    }
    
    
     func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       let obj = newEventsData[indexPath.row]
        self.passEventDetails = obj
       performSegueWithIdentifier("eventDetails", sender: nil)
    }
    
    
    @IBAction func sortAction(sender: AnyObject) {
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("userId") as? Int
        if sortType == "None"
        {
         let predicate = NSPredicate(format: "userId == %d",userId!)
            sortType = "Asc"
            EventUser.updateUser(predicate, sortType: sortType!)
            NSUserDefaults.standardUserDefaults().setObject(sortType, forKey: "sortType")
            EventDatas.fetchEventDetails(sortType!,entity: "Events") { (data) -> Void in
                self.newEventsData = data
                self.eventsCollectionView.reloadData()
                self.setSortImages()
                
               
            }
             return
        }
        if sortType == "Asc"
        {
            let predicate = NSPredicate(format: "userId == %d",userId!)
               sortType = "Dsc"
            EventUser.updateUser(predicate, sortType: sortType!)
           NSUserDefaults.standardUserDefaults().setObject(sortType, forKey: "sortType")
            EventDatas.fetchEventDetails(sortType!,entity: "Events") { (data) -> Void in
                self.newEventsData = data
                self.eventsCollectionView.reloadData()
               
                self.setSortImages()
            }
             return
        }
        if sortType == "Dsc"
        {
             sortType = "None"
            let predicate = NSPredicate(format: "userId == %d",userId!)
            EventUser.updateUser(predicate, sortType: sortType!)
           NSUserDefaults.standardUserDefaults().setObject(sortType, forKey: "sortType")
            EventDatas.fetchEventDetails(sortType!,entity: "Events") { (data) -> Void in
                self.newEventsData = data
                self.eventsCollectionView.reloadData()
                self.setSortImages()
                
            }
            return

        }
        
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "eventDetails" {
            if let nextViewController = segue.destinationViewController as? EventDetailsViewController
            {
           
                nextViewController.detailEvent = passEventDetails
            }
                       
        }

    }
 

}
