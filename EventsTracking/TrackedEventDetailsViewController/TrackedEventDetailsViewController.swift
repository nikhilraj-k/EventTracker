//
//  TrackedEventDetailsViewController.swift
//  EventsTracking
//
//  Created by Nikhil Raj K on 14/11/16.
//  Copyright © 2016 Nikhil Raj K. All rights reserved.
//

import UIKit

class TrackedEventDetailsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var eventDetailCollectionView: UICollectionView!
     var eventListViewLayOut = ListCollectionViewFlowLayout()
    var trackedEventData = [TrackedEvents]()
    var passTrackedEventDetails:TrackedEvents?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        setupInitialLayout()
       
        
        //swipe gesture for showing user tapped actions
       // let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        //swipe left for dismiss the view
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: ("handleSwipes:"))
        rightSwipe.direction = .Right
        view.addGestureRecognizer(rightSwipe)

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Tracked Events"
        
        let userId = NSUserDefaults.standardUserDefaults().valueForKey("userId") as? Int
        // Do any additional setup after loading the view.
        let predicate = NSPredicate(format: "userId == %d",userId!)
        TrackedEvents.fetchTrackedEventDetails(false, entity: "TrackedEvents", compPredicate: nil, sinPredicate: predicate) { (data) in
            if data.count == 0
            {
              self.navigationController?.popViewControllerAnimated(true)
            }
            self.trackedEventData = data
            print(self.trackedEventData.count)
            
        }
         eventDetailCollectionView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func setupInitialLayout() {
  
        eventDetailCollectionView.backgroundColor = UIColor.lightGrayColor()
       eventDetailCollectionView.collectionViewLayout = eventListViewLayOut
    }
    
    func registerNibs()
    {
        self.eventDetailCollectionView.registerNib(UINib(nibName: "EvenetsListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listIdentifier")
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackedEventData.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
   
           let obj = trackedEventData[indexPath.row]
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
                cell.eventEntryLabel.text = eEntry
            }
            return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let obj = trackedEventData[indexPath.row]
        self.passTrackedEventDetails = obj
        
        performSegueWithIdentifier("trackedEventDetails", sender: nil)
    }

    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "trackedEventDetails" {
            if let nextViewController = segue.destinationViewController as? EventDetailsViewController
            {
                
                nextViewController.detailTrackEvent = passTrackedEventDetails
                nextViewController.eventStatus = false
            }
            
        }
        
    
    }
    

}
