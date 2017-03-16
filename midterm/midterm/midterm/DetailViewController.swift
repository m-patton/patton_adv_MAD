//
//  DetailViewController.swift
//  midterm
//
//  Created by Mae Patton on 3/16/17.
//  Copyright © 2017 atlas. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var run = [String]()
    var selectedResort = 0
    
    var searchController : UISearchController!
    
    var resortListDetail = Runs()
    
    override func viewWillAppear(_ animated: Bool) {
        resortListDetail.runs = Array(resortListDetail.resortData.keys)
        let chosenResort =
            resortListDetail.runs[selectedResort]
        run = resortListDetail.resortData[chosenResort]! as [String]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        ///SEARCH
        //resortListDetail.runs = Array(resortListDetail.resortData.keys)
        let resultsController = SearchResultsController()
        resultsController.allwords = run
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchBar.placeholder = "Enter a search term"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView=searchController.searchBar
        searchController.searchResultsUpdater = resultsController
        
        ///
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
        return run.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = run[indexPath.row]
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the country from the array 
            run.remove(at: indexPath.row)
            let chosenResort = resortListDetail.runs[selectedResort]
            //Delete from the data model
            resortListDetail.resortData[chosenResort]?.remove(at: indexPath.row)
            // Delete the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }


    
   
    
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        if segue.identifier=="doneSegue"{
            let source = segue.source as! AddRunViewController //only add a country if there is text in the textfield if ((source.addedCountry.isEmpty) == false){
            run.append(source.addedRun)
            tableView.reloadData()
            let chosenResort = resortListDetail.runs[selectedResort]
            resortListDetail.resortData[chosenResort]?.append(source.addedRun)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Row selected", message: "row: \(run[indexPath.row])", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
   
    

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
