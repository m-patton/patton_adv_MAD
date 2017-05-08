//
//  TableViewController.swift
//  p1m3
//
//  Created by Mae Patton on 3/12/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class TableViewController: UITableViewController, NoteViewDelegate {
    
    var arrNotes = [[String:Any]]()
    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        ///USER DEFAULTS
        ///this is where you load the saved information in... if it exists
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.array(forKey: "notes") as? [[String:Any]] else {
            return
        }
        arrNotes = data //these are my saved notes
        tableView.reloadData()
    }
        
    func didUpdateNoteWithTitle2(newTitle: String, newBody: String, newBody2: String, newImage: NSData) {
        
        //this is how i will update that specific note
        self.arrNotes[self.selectedIndex]["title"] = newTitle //title
        self.arrNotes[self.selectedIndex]["body"] = newBody //peak
        self.arrNotes[self.selectedIndex]["body2"] = newBody2 //pit
        self.arrNotes[self.selectedIndex]["image"] = newImage //image
        
        self.tableView.reloadData()
        saveNotesArray()
    }


    
    @IBAction func newNote() {
        //help from packtpub.com/sites/default/files/downloads/6718OS_Chapter9.pdf
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, y"
        let dateStr = dateFormatter.string(from: date as Date)
        let image = UIImage(named: "mntwadd.png")
        let imageData : NSData = UIImagePNGRepresentation(image!)! as NSData
        //new dictionary with 3 keys and values for each
        var newEntry = ["title" : dateStr, "body" : "" , "body2" : "", "image" : imageData] as [String : Any]
        //i want title to always be date but body1 and body2 will be the answers to each of the questions
        
        arrNotes.insert(newEntry, at: 0) //always put new one at the front so it is in correct order when array loads in
        self.selectedIndex = 0
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
        return arrNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel!.text = arrNotes[indexPath.row]["title"] as! String?
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "showEditorSegue", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print(selectedIndex)
            self.arrNotes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            let userDefaults = UserDefaults.standard
            userDefaults.set(arrNotes, forKey: "notes")
        } else if editingStyle == .insert {
        }
    }
    
    func saveNotesArray() {
        ///USER DEFAULTS
        ///This is where you save the information
        UserDefaults.standard.set(arrNotes, forKey: "notes")
        UserDefaults.standard.synchronize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dailyNoteView = segue.destination as! NotesViewController
        print(selectedIndex)
        dailyNoteView.navigationItem.title = arrNotes[self.selectedIndex]["title"] as! String?
        dailyNoteView.strBodyText = arrNotes[self.selectedIndex]["body"] as! String!
        dailyNoteView.strBodyText2 = arrNotes[self.selectedIndex]["body2"] as! String!
        dailyNoteView.dataImage = arrNotes[self.selectedIndex]["image"] as! NSData!
        dailyNoteView.delegate = self
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
