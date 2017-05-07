//
//  NotesViewController.swift
//  p1m3
//
//  Created by Mae Patton on 3/12/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


protocol NoteViewDelegate {
    
    func didUpdateNoteWithTitle2(newTitle : String, newBody : String, newBody2: String, newImage : NSData)
}
class NotesViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var delegate : NoteViewDelegate? ///do this
    
    
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var txtBody : UITextView! ///this is the first text view
    @IBOutlet weak var txtBody2 : UITextView! /// you dont need this
    
    var strBodyText : String! ///this is the actual text
    var strBodyText2 : String!
    var dataImage : NSData!
    
    
    @IBOutlet weak var myImage: UIImageView!
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary //can also say camera
        image.allowsEditing = false
        self.present(image, animated: true){
            //after complete
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImage.image = image
            //encode the image
            ///SAVE NEW IMAGE
            let imageData:NSData = UIImagePNGRepresentation(image)! as NSData
            /*
            UserDefaults.standard.set(imageData, forKey: "savedImage")
            
            let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            myImage.image=UIImage(data: data as Data)
             */
            
            
        }else{
            //error
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtBody.text = self.strBodyText ///first text view
        self.txtBody2.text = self.strBodyText2 //second text view
        if let data = dataImage{
            let data2 = dataImage as NSData
            self.myImage.image = UIImage(data: data2 as Data)
        }
        //self.myImage.image = UIImage(data: data as Data)
        
        
        self.txtBody.delegate = self
        self.txtBody2.delegate = self
        //self.txtBody.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneEditingBody() {
        self.txtBody.resignFirstResponder() ///this is to get rid of the keyboard yay
        self.txtBody2.resignFirstResponder()
        //self.doneButton.tintColor = UIColor.clear ///ignore this shit
        let imageData:NSData = UIImagePNGRepresentation(myImage.image!)! as NSData
        if self.delegate != nil {
            self.delegate!.didUpdateNoteWithTitle2(newTitle: self.navigationItem.title!, newBody: self.txtBody.text, newBody2: self.txtBody2.text, newImage:imageData)
        }

    }
    /*
     if let imgdata = UserDefaults.standard.object(forKey: "savedImage"){
     let imgdata2 = UserDefaults.standard.object(forKey: "savedImage") as! NSData
     userImage.image=UIImage(data: imgdata2 as Data)
     }

     
     */
    
    ///THIS IS IMPORTANT
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let imageData:NSData = UIImagePNGRepresentation(myImage.image!)! as NSData
        if self.delegate != nil {
            self.delegate!.didUpdateNoteWithTitle2(newTitle: self.navigationItem.title!, newBody: self.txtBody.text, newBody2: self.txtBody2.text, newImage:imageData)
        }
    }
    
    /*
    func textViewDidBeginEditing(textView: UITextView) {
        
        print("yay")
    }*/

    /// You don't really need this... this is so that when you press return on the keyboard it goes away
    /// but text views use return to go to the next line which can be useful
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
