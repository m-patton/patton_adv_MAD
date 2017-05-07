//
//  GoalsTableViewController.swift
//  p1m3
//
//  Created by Mae Patton on 3/12/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class GoalsTableViewController: UITableViewController, UITextFieldDelegate {
    var selectedIndex = -1
    var goalsArr = [String]()
    
    @IBOutlet weak var goalText: UITextField!
    
    @IBAction func addGoal(_ sender: UIButton) {
        self.goalText.resignFirstResponder()
        var newItem = goalText.text!
        goalsArr.insert(newItem, at: 0)
        self.selectedIndex = 0
        self.tableView.reloadData()
        saveGoals()
        goalText.text = ""
        
    }
    
    func saveGoals() {
        
        UserDefaults.standard.set(goalsArr, forKey: "goals")
        UserDefaults.standard.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.goalText.delegate = self
        
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.array(forKey: "goals") as? [String] else {
            return
        }
        
        goalsArr = data
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return goalsArr.count
    }
    
    //help with checkmarks stackoverflow.com/questions/30059704/uitableviewcell-checkmark-to-be-toggled-on-and-off-when-tapped-swift
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)//this is so selected fades out
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                cell.textLabel?.textColor = UIColor(red: 214/255, green: 101/255, blue: 90/255, alpha: 1)
                //UserDefaults.standard.set(cell.accessoryType, forKey: "check")
                //how do you save the accessory in userdefaults...?
                
            }else{
                cell.accessoryType = .none
                cell.textLabel?.textColor = UIColor.black
                //UserDefaults.standard.set(cell.accessoryType, forKey: "check")
            }
            
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel!.text = goalsArr[indexPath.row]


        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print(selectedIndex)
            self.goalsArr.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            let userDefaults = UserDefaults.standard
            userDefaults.set(goalsArr, forKey: "goals")
            
        } else if editingStyle == .insert {
        }
    }
    
    
    
    

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
