//
//  ViewController.swift
//  labtwo
//
//  Copyright © 2017 Mae Patton. All rights reserved.
//  Create an app with navigation controllers and table views
//  that let the user add and delete data.
//One of the table views should include a search bar. 
//  The data in the app should be persistent.
//Your app should be adaptive for different size classes and include app icons and a launch screen
//

import UIKit

class ViewController: UITableViewController {
    
    var wordList = Words()
    var words = [String]()
    //var letters : [String]!
    let filen = "data.plist"
    
    var searchController : UISearchController!
    //let searchController = UISearchController(searchResultsController: nil)
    //var filteredWords = [Words]()
    
    func getDataFile() -> String? {
        guard let pathString = Bundle.main.path(forResource: "words", ofType: "plist") else {
            return nil
        }
        return pathString
    }

    
    func docFilePath(_ filename: String) -> String?{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = path[0] as NSString
        return dir.appendingPathComponent(filename)
    }
    
    /*
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredWords = wordList.words.filter {words in
            return wordList.words.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }*/


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path:String?
        let filePath = docFilePath(filen)
        
        if FileManager.default.fileExists(atPath: filePath!){
            path = filePath
        }
        else {
            path = getDataFile()
        }
        
        wordList.wordData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        wordList.words = Array(wordList.wordData.keys)
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: app)
    
        
        
        //search results
        let resultsController = SearchResultsController()
        resultsController.allwords = words
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchBar.placeholder = "Enter a search word"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView=searchController.searchBar
        searchController.searchResultsUpdater = resultsController

    }
    
    func applicationWillResignActive(_ notification: Notification){
        let filePath = docFilePath(filen)
        let data = NSMutableDictionary()
        data.addEntries(from: wordList.wordData)
        data.write(toFile: filePath!, atomically: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       /*
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredWords.count
        }*/
        return wordList.wordData.count
        //return wordList.wordData.count
    }
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //configure the cell
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        if searchController.isActive && searchController.searchBar.text != "" {
            wordList = filteredWords[indexPath.row]
        } else {
            wordList = wordData[indexPath.row]
        }
        //cell.textLabel?.text = candy.name
        
        cell.textLabel?.text = wordList.words[indexPath.row]
        return cell*/
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = wordList.words[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { if segue.identifier == "wordsegue" {
        let detailVC = segue.destination as! DetailViewController
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
        detailVC.title = wordList.words[indexPath.row]
        detailVC.letterListDetail = wordList
        detailVC.selectedLetter = indexPath.row
        }
    }


}


