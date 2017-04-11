//
//  TableViewController.swift
//  lab6
//
//  Created by Mae Patton on 4/10/17.
//  Copyright © 2017 atlas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class TableViewController: UITableViewController {
    var ref: FIRDatabaseReference!
    var quotes = [Quote]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        ref.observe(FIRDataEventType.value, with: { snapshot in
            self.quotes=[]
            for quote in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let newQuote = Quote(snapshot: quote)
                self.quotes.append(newQuote)
            }
            self.tableView.reloadData()
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindSegue(segue:UIStoryboardSegue){
        if segue.identifier == "savesegue" {
            let source = segue.source as! AddViewController
            if source.addedquote.isEmpty == false {
                let newQuote = Quote(newname: source.addedname, newquote:source.addedquote)
                quotes.append(newQuote)
                let newQuoteDict = ["name": source.addedname, "quote": source.addedquote]
                
                let quoteref = ref.child(source.addedname)
                quoteref.setValue(newQuoteDict)
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return quotes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let quote = quotes[indexPath.row]
        cell.nameLabel.text = quote.name
        cell.quoteLabel.text = quote.quote
        //cell.textLabel!.text = quote.name
        // Configure the cell...
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
            let quote = quotes[indexPath.row]
            let quoteref = ref.child(quote.name)
            quoteref.ref.removeValue()
            //tableView.deleteRows(at: [indexPath], with: .fade)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
