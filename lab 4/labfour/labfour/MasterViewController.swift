//
//  MasterViewController.swift
//  labfour
//
//  Created by Mae Patton on 3/20/17.
//  Copyright © 2017 atlas. All rights reserved.
//
//Lab 4: Create a universal app that uses a split view controller to show data in a master/detail relationship. The data in the app should be loaded from a plist. Your app should be adaptive for different size classes and include app icons and a launch screen.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    var flowers = [[String : String]]()
    
    func getDataFile() -> String? {
        guard let pathString = Bundle.main.path(forResource: "flowers", ofType: "plist") else {
            return nil
        }
        return pathString }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let path = getDataFile() else{
            print("Error loading file")
            return
        }
        let alldata = NSDictionary(contentsOfFile: path) as! [String: [[String : String]]]
        if alldata.isEmpty != true {
            flowers = Array(alldata["flowers"]!)
        }
        
        /*
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton*/
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }*/

    // MARK: - Segues

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let flower = flowers[indexPath.row]
            let url = flower["url"]! as String
            let name = flower["name"]! as String
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.detailItem = url as AnyObject?
            controller.title = name
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flowers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let flower = flowers[indexPath.row]
        
        cell.textLabel!.text = flower["name"]! as String
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    /*
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }*/


}

