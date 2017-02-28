//
//  FirstViewController.swift
//  p1m2
//
//  Created by Mae Patton on 2/28/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController {
    
    var dateList = Notes()
    var selectedDate = 0
    
    func getDataFile() -> String? {
        guard let pathString = Bundle.main.path(forResource: "testnotes", ofType: "plist")
        else {
            return nil
        }
        return pathString
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let path = getDataFile() else{
            print("Error loading file")
            return
        }

        dateList.dateData = NSDictionary(contentsOfFile: path) as! [String : [String]]
        dateList.note = Array(dateList.dateData.keys)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateList.dateData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dateList.note[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the country from the array countries.remove(at: indexPath.row) 
            let chosenDate = dateList.note[selectedDate]
            //Delete from the data model
            dateList.dateData[chosenDate]?.remove(at: indexPath.row)
            // Delete the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

