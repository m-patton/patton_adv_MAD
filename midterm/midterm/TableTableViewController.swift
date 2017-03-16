//
//  TableTableViewController.swift
//  midterm
//
//  Created by Mae Patton on 3/16/17.
//  Copyright © 2017 atlas. All rights reserved.
//

import UIKit

class TableTableViewController: UITableViewController {
    
    var resortList = Runs()
    let kfilename = "data.plist"
    
    func docFilePath(_ filename: String) -> String?{ //locate the documents directory
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = path[0] as NSString
        return dir.appendingPathComponent(filename)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ///
        
        
        let path:String?
        let filePath = docFilePath(kfilename) //path to data file
        //print(filePath)
        
        //if the data file exists, use it
        if FileManager.default.fileExists(atPath: filePath!){
            path = filePath
            //print(path)
        }
        else {
            path = getDataFile()
        }
        
        //load the data of the plist file into the dictionary
        resortList.resortData = NSDictionary(contentsOfFile: path!) as! [String: [String]]

        //puts all the continents in an array
        resortList.runs = Array(resortList.resortData.keys)
        
        //application instance
        let app = UIApplication.shared
        //subscribe to the UIApplicationWillResignActiveNotification notification
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: app)
        
        
        ///

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        //load the data of the plist file into the dictionary
        //resortList.resortData = NSDictionary(contentsOfFile: path) as! [String: [String]]
        //puts all the continents in an array
        //resortList.runs = Array(resortList.resortData.keys)
    }
    
    func applicationWillResignActive(_ notification: Notification){
        let filePath = docFilePath(kfilename)
        let data = NSMutableDictionary()
        //adds our whole dictionary to the data dictionary 
        data.addEntries(from: resortList.resortData)
        //write the contents of the array to our plist file
        data.write(toFile: filePath!, atomically: true)
    }
    
    func getDataFile() -> String? {
            guard let pathString = Bundle.main.path(forResource: "ski", ofType: "plist") else {
            return nil
        }
        return pathString }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resortList.resortData.count }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = resortList.runs[indexPath.row]

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { if segue.identifier == "runssegue" {
        let detailVC = segue.destination as! DetailViewController
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
        detailVC.title = resortList.runs[indexPath.row]
        detailVC.resortListDetail = resortList
        detailVC.selectedResort = indexPath.row
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
