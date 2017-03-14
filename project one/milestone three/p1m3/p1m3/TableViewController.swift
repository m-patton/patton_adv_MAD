//
//  TableViewController.swift
//  p1m3
//
//  Created by Mae Patton on 3/12/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, NoteViewDelegate {
    
    var arrNotes = [[String:String]]()
    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        /*
        if let newNotes = NSUserDefaults.standardUserDefaults().
        arrayForKey("notes") as? [[String:String]] {
            
            //set the instance variable to the newNotes variable
            arrNotes = newNotes
            
        }*/
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.array(forKey: "notes") as? [[String:String]] else {
            return
        }
        arrNotes = data
        tableView.reloadData()
    }
    
    func didUpdateNoteWithTitle(newTitle: String, newBody: String, newBody2: String) {
        
        //update the respective values
        self.arrNotes[self.selectedIndex]["title"] = newTitle
        self.arrNotes[self.selectedIndex]["body"] = newBody
        self.arrNotes[self.selectedIndex]["body2"] = newBody2
        
        //refresh the view
        self.tableView.reloadData()
        saveNotesArray()
    }

    
    @IBAction func newNote() {
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, y"
        let dateStr = dateFormatter.string(from: date as Date)
        //self.navigationItem.title = dateStr
        
        //new dictionary with 3 keys and test values for each
        var newDict = ["title" : dateStr, "body" : "" , "body2" : ""]
        
        //add the dictionary to the front (or top) of the array
        arrNotes.insert(newDict, at: 0)
        
        self.selectedIndex = 0
        
        //reload the table ( refresh the view)
        self.tableView.reloadData()
        saveNotesArray()
        performSegue(withIdentifier: "showEditorSegue", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrNotes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        
        // set the text to a test value to make sure it's working
        //cell.textLabel!.text = "Test Value"
        cell.textLabel!.text = arrNotes[indexPath.row]["title"]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "showEditorSegue", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //let chosenDate = arrNotes[selectedIndex]
            print(selectedIndex)
            self.arrNotes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            //print("deleted", selectedIndex)
            let userDefaults = UserDefaults.standard
            userDefaults.set(arrNotes, forKey: "notes")
            //userDefaults.setObject(dictionaryWithValues(forKeys: "notes")
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func saveNotesArray() {
        
        UserDefaults.standard.set(arrNotes, forKey: "notes")
        UserDefaults.standard.synchronize()
    }
    
    
    
    
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //grab the view controller we're gong to transition to
        let notesEditorVC = segue.destination as! NotesViewController
        //set the title of the navigation bar to the selectedIndex's title
        print(selectedIndex)
        notesEditorVC.navigationItem.title = arrNotes[self.selectedIndex]["title"]
        notesEditorVC.strBodyText = arrNotes[self.selectedIndex]["body"]
        notesEditorVC.strBodyText2 = arrNotes[self.selectedIndex]["body2"]
        notesEditorVC.delegate = self
        
        //set the delegate to "self", so the method gets called here
        //notesEditorVC.delegate = self
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
