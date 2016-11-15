//
//  ViewController.swift
//  EventsTracking
//
//  Created by Nikhil Raj K on 12/11/16.
//  Copyright © 2016 Nikhil Raj K. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    
    @IBOutlet weak var gridButton: UIButton!
    
    @IBOutlet weak var listButton: UIButton!
    var listStatus:Bool = true
    var gridStatus:Bool = false
    var listFlowOut = ListCollectionViewFlowLayout()
    var gridLayOut = GridCollectionViewLayout()
 var myArray = ["1","2","","",""]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.eventsCollectionView.registerNib(UINib(nibName: "EvenetsListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listIdentifier")
        self.eventsCollectionView.registerNib(UINib(nibName: "EventsGridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "gridIdentifier")
        listButton.userInteractionEnabled = false
        setupInitialLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupInitialLayout() {
        listStatus = true
        eventsCollectionView.collectionViewLayout = listFlowOut
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 205
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if Bool(listStatus){
        
        let cell :EvenetsListCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("listIdentifier", forIndexPath: indexPath) as!
            EvenetsListCollectionViewCell
          
        return cell
        }
        
        else
        {
            let cell :EventsGridCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("gridIdentifier", forIndexPath: indexPath) as! EventsGridCollectionViewCell
        

            return cell
            
        }
    }
    
    
    @IBAction func listAction(sender: AnyObject) {
        
       listButton.userInteractionEnabled = false
        gridButton.userInteractionEnabled = true
          self.listStatus = true
       self.eventsCollectionView.reloadData()
        
        self.eventsCollectionView.collectionViewLayout.invalidateLayout()
       
        
        UIView.animateWithDuration(0.2, animations: {}) { (finish) in
           
            if(finish)
            {
               
          
        
            
                 self.eventsCollectionView.collectionViewLayout = self.listFlowOut
                   // self.eventsCollectionView.setCollectionViewLayout(self.listFlowOut, animated: true)
                    self.eventsCollectionView.reloadData()
                    
                
            }
            
        }
 
      
       
/*[self.eventsCollectionView .performBatchUpdates({
   
    self.eventsCollectionView.collectionViewLayout.invalidateLayout()
    
   
    
    }, completion: { (finish) in
        if(finish)
        {
           
             self.eventsCollectionView.setCollectionViewLayout(self.listFlowOut, animated: true)
            self.eventsCollectionView.reloadData()
                       self.gridButton.userInteractionEnabled = true
        }
        
})]*/
       
           }

    @IBAction func gridAction(sender: AnyObject) {
        listButton.userInteractionEnabled = true
        gridButton.userInteractionEnabled = false
        self.listStatus = false
        self.eventsCollectionView.reloadData()
       

        
        self.eventsCollectionView.collectionViewLayout.invalidateLayout()

       UIView.animateWithDuration(0.2, animations: {}) { (finish) in
       
         if(finish)
            
         {
            self.eventsCollectionView.collectionViewLayout = self.gridLayOut
            
          
          //      self.eventsCollectionView.setCollectionViewLayout(self.gridLayOut, animated: true)
                self.eventsCollectionView.reloadData()
                
            
            
            }
        }
           /*
        [self.eventsCollectionView .performBatchUpdates({
              self.eventsCollectionView.collectionViewLayout.invalidateLayout()
            
            }, completion: { (finish) in
                if(finish)
                {
                   
                    
                  
                    self.eventsCollectionView.setCollectionViewLayout(self.gridLayOut, animated: true)
                    self.eventsCollectionView.reloadData()

                    self.listButton.userInteractionEnabled = true
                }
                
        })]*/
        
        
 
                
        
            
        
        //self.eventsCollectionView.reloadData()
       

    }

}

