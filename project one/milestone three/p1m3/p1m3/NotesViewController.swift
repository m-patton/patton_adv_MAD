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
        //self.txtBody.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneEditingBody() {
        
        //hides the keyboard
        self.txtBody.resignFirstResponder()
        self.txtBody2.resignFirstResponder()
        self.doneButton.tintColor = UIColor.clear
        
        if self.delegate != nil {
            //i only want to change the body not the title...
            self.delegate!.didUpdateNoteWithTitle(newTitle: self.navigationItem.title!, newBody: self.txtBody.text, newBody2: self.txtBody2.text)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        if self.delegate != nil {
            self.delegate!.didUpdateNoteWithTitle(newTitle: self.navigationItem.title!, newBody: self.txtBody.text, newBody2: self.txtBody2.text)
        }
    }
    
    /*
    func textViewDidBeginEditing(textView: UITextView) {
        
        print("text view: ", textView.text)
    }*/

    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") { //hmmm i dont know if i want this to happen or nah
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
