//
//  MealTableViewController.swift
//  RememberView
//
//  Created by pegasus on 2016/11/26.
//  Copyright © 2016年 Kelly. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
  
  // MARK: Properties
  
  var meals = [Meal]()
  
  // MARK: Actions
  
  @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
    
    
    
    if let svc = sender.source as? MealViewController, let meal = svc.meal {
      
      // 如果 tableView 中有某個 row 已經被選取，就更新此 row 的資料
      if let selectedIndexPath = tableView.indexPathForSelectedRow {
        
        meals[selectedIndexPath.row] = meal
        tableView.reloadRows(at: [selectedIndexPath], with: .none)
      }
      
      // Add a new meal. update model then view
      else {
        
        let newIndexPath = IndexPath(row: meals.count, section: 0)
        
        meals += [meal]
        tableView.insertRows(at: [newIndexPath], with: .bottom)
      }
      
      // 儲存資料
      saveData()
    }
  }
  
  // MARK: - NSCoding
  
  func saveData() {
    let isSaved = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.archivePath)
    if !isSaved {
      print("Save failed ...")
    } else {
      print("Saved to \(Meal.archivePath)")
    }
  }
  
  func loadData() -> [Meal]? {
    return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.archivePath) as? [Meal]
  }
  
  // MARK: - Controller Life Cycle

  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    // add edit button
    navigationItem.leftBarButtonItem = editButtonItem
    
    // load data
    if let savedData = loadData() {
      meals = savedData
    } else {
      loadSampleMeals()
    }
    
  }
  
  // helper methods
  func loadSampleMeals() {
    let photo1 = UIImage(named: "meal1")!
    let meal1 = Meal(name: "咖啡拿鐵", photo: photo1, rating: 4)!
    
    let photo2 = UIImage(named: "meal2")!
    let meal2 = Meal(name: "荷包蛋", photo: photo2, rating: 5)!
    
    let photo3 = UIImage(named: "meal3")!
    let meal3 = Meal(name: "披薩", photo: photo3, rating: 3)!
    
    meals += [meal1, meal2, meal3]
  }


  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
      return meals.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as! MealTableViewCell

    // Configure the cell...
    let meal = meals[indexPath.row]
    
    cell.labelName.text = meal.name
    cell.imgviewPhoto.image = meal.photo
    cell.ratingControl.rating = meal.rating

    return cell
  }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      
        if editingStyle == .delete {
          
          // Delete the row from the data source
          meals.remove(at: indexPath.row)
          saveData()
          
          // update table view
          tableView.deleteRows(at: [indexPath], with: .fade)
          
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    switch segue.identifier! {
      
      case "ShowMeal":
        
        let dvc = segue.destination as! MealViewController
        if let cell = sender as? MealTableViewCell {
          // 先跟 tableView 要編號，再跟 meals 要資料
          let indexPath = tableView.indexPath(for: cell)!
          dvc.meal = meals[indexPath.row]
        }
      
      default:
        break
    }
  }

}
