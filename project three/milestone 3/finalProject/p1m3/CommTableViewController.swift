//
//  CommTableViewController.swift
//  
//
//  Created by Mae Patton on 5/5/17.
//
//

import UIKit
import Firebase
import FirebaseDatabase

class CommTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var ref: FIRDatabaseReference!
    var selectedIndex = -1
    var counter = 1
    
    var posts = [Post]()
    
    var userName = ""
    @IBOutlet weak var postField: UITextView!
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    
    @IBAction func savePost(_ sender: Any) {
        self.postField.resignFirstResponder()
        
        var counting = "\(counter)" //this is the counter as a string
        let newPost = Post(newname: userName, newpost: postField.text!, newid: "post" + counting)
        posts.append(newPost)
        let newPostDict = ["name": userName, "post": postField.text!, "postid" : "post" + counting]
        //self.ref.child("training").child("ID" + counter).child("red").setValue(red)
        let postref = ref.child("Posts").child("post" + counting)
        postref.setValue(newPostDict)
        self.postField.text=""
        counter += 1
        counting = "\(counter)"
        print("count is at: ", counter)
        
        ///SAVE THE COUNT HERE
        
        ref = FIRDatabase.database().reference()
        self.ref.child("count").child("count").setValue(counting)
        //sending the count to firebase so each post has specific id
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        ref.child("Posts").observe(FIRDataEventType.value, with: {snapshot in
            self.posts=[]
            for post in snapshot.children.allObjects as! [FIRDataSnapshot]{
                let newPost = Post(snapshot: post)
                self.posts.insert(newPost, at: 0)
                //self.posts.append(newPost)
            }
            self.tableView.reloadData()
        })
        
        tableView.delegate = self
        tableView.dataSource = self
        self.postField.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        ///GET THE COUNT HERE
        
        ref.child("count").observeSingleEvent(of: .value, with: { (snapshot) in
            let count = snapshot.value as? NSDictionary
            let county = count?["count"] as? String ?? ""
            self.counter = Int(county)!
            print("got the count: ", self.counter)
            
        })
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        if let name = UserDefaults.standard.string(forKey: "name")
        {
            userName =  name
        }else {
            userName = "User"
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.postField.text = ""
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            print("current index ", indexPath)
            
            let post = posts[indexPath.row]
            let postref = ref.child("Posts").child(post.postid)
            //each has a unique post id
            postref.ref.removeValue()
            
            //This works but I should disable it and come up with a different delete method for foum posts...
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommTableViewCell
        let post = posts[indexPath.row]
        cell.nameLabel.text = post.name
        cell.postLabel.text = post.post
        return cell
        
        
        // Configure the cell...
    }
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
