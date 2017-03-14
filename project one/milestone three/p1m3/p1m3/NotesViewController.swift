//
//  NotesViewController.swift
//  p1m3
//
//  Created by Mae Patton on 3/12/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import UIKit

protocol NoteViewDelegate {
    
    
    //the name of the function that will be implemented
    func didUpdateNoteWithTitle(newTitle : String, newBody : String, newBody2: String)
    //func didUpdateNote(newBody : String, newBody2 : String)
}
class NotesViewController: UIViewController, UITextViewDelegate {
    var delegate : NoteViewDelegate?
    
    @IBOutlet weak var doneButton: UIBarButtonItem!

    @IBOutlet weak var txtBody : UITextView!
    @IBOutlet weak var txtBody2 : UITextView!
    
    var strBodyText : String!
    var strBodyText2 : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtBody.text = self.strBodyText //first text view
        self.txtBody2.text = self.strBodyText2 //second text view
        
        self.txtBody.delegate = self
        self.txtBody2.delegate = self
        //self.doneButton.tintColor = UIColor.clear
        //makes the keyboard appear immediately
        //self.txtBody.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneEditingBody() {
        
        //hides the keyboard
        self.txtBody.resignFirstResponder()
        self.txtBody2.resignFirstResponder()
        
        //makes the button invisible (still allowed to be pressed, butthat's okay for this app)
        self.doneButton.tintColor = UIColor.clear
        
        if self.delegate != nil {
            //self.delegate!.didUpdateNoteWithTitle( newTitle: self.navigationItem.title!, andBody: self.txtBody.text)
            //i only want to change the body not the title...
            self.delegate!.didUpdateNoteWithTitle(newTitle: self.navigationItem.title!, newBody: self.txtBody.text, newBody2: self.txtBody2.text)
            //self.delegate!.didUpdateNoteWithTitle( self.navigationItem.title!, andBody: self.txtBody.text)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        //tell the main view controller that we're going to update the selected item
        //but only if the delegate is NOT nil
        if self.delegate != nil {
            //self.delegate!.didUpdateNote(newBody: self.txtBody.text, newBody2: self.txtBody2.text)
            self.delegate!.didUpdateNoteWithTitle(newTitle: self.navigationItem.title!, newBody: self.txtBody.text, newBody2: self.txtBody2.text)
        }
    }
    
    /*
    func textViewDidChange(textView: UITextView) {
        
        //separate the body into multiple sections
        //let components = self.txtBody.text.componentsSeparatedByString("\n") as! [String]
        let parts = self.txtBody.text.components(separatedBy: "\n")
        //reset the title to blank (in case there are no componentswith valid text)
        self.navigationItem.title = ""
        
        //loop through each item in the components array (each item is auto-detected as a String)
        for item in parts {
            
            //if the number of letters in the item (AFTER getting rid ofextra white space) is greater than 0...
            if countElements(item.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())) > 0 {
                
                //then set the title to the item itself, and break out ofthe for loop
                self.navigationItem.title = item
                break
            }
        }
    }*/
    
    
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        //sets the color of the Done button to the default blue
        //it's not a pre-defined value like clearColor, so we give it the exact RGB values
        print("text view: ", textView.text)
        self.doneButton.tintColor = UIColor(red: 0, green:122.0/255.0, blue: 1, alpha: 1)
    }
    
        
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createTitle(){
        if(self.navigationItem.title == "") {
            let date = NSDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, y"
            let dateStr = dateFormatter.string(from: date as Date)
            self.navigationItem.title = dateStr
        }
        else{
            return
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
