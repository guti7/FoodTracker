//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Guti on 7/10/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var meals = [Meal]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved meals,
        
        if let savedMeals = loadMeals() {
            meals += savedMeals
        } else {
            // Load the sample data.
            loadSampleMeals()
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    // Helper to load sample data into the app
    func loadSampleMeals() {
        let photo1 = UIImage(named: "salad")
        let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4)!
        
        let photo2 = UIImage(named: "potatoes")
        let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5)!
        
        let photo3 = UIImage(named: "spaghetti")
        let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3)!
        
        meals += [meal1, meal2, meal3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using
        // a cell identifier
        let cellIdentifier = "MealTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        
        // Ferches the appropriate meal for the data souce layout.
        let meal = meals[indexPath.row]

        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }
    
    
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.meal {
            // checks if source can be downcast, assigns to local source
            // and checks if meal can be assigned to local meal
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                
                // then you can add a meal
                // computes location in the table view where 
                // the new table view cell(the new meal) will be inserted
                let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                
                meals.append(meal) // add to data model
                
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
            saveMeals()
            
        }
    }


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            meals.removeAtIndex(indexPath.row)
            saveMeals()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowDetail" {
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            
            // get the cell of origin segue
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            }
            
        } else if segue.identifier == "AddItem" {
            print("Adding new meal.")
        }
        
    }
    
    
    // MARK: NSCoding
    func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }
}
