//
//  UserViewController.swift
//  p1m3
//
//  Created by Mae Patton on 5/6/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UINavigationControllerDelegate,  UIImagePickerControllerDelegate, UITextFieldDelegate {
    //This is where the user can change their name or profile image
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
         UserDefaults.standard.set(nameField.text!, forKey: "name")
         dismiss(animated: true, completion: nil)
    }
    
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
            profileImage.image = image
            //encode the image
            ///SAVE NEW IMAGE
            let imageData:NSData = UIImagePNGRepresentation(image)! as NSData
            UserDefaults.standard.set(imageData, forKey: "savedImage")
            
            let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            profileImage.image=UIImage(data: data as Data)
            
            
        }else{
            //error
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameField.delegate = self
        nameField.textAlignment = .right
        if let name = UserDefaults.standard.string(forKey: "name")
        {
            //UserDefaults.standard.set(nameLabel.text!, forKey: "name")
            nameField.text = name
        }else {
            nameField.placeholder = "Your Name"
        }


        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let name = UserDefaults.standard.string(forKey: "name")
        {
            //UserDefaults.standard.set(nameLabel.text!, forKey: "name")
            nameField.text = name
        }else {
            nameField.placeholder = "Your Name"
        }
        
        if let imgdata = UserDefaults.standard.object(forKey: "savedImage"){
            let imgdata2 = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            profileImage.image=UIImage(data: imgdata2 as Data)
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        UserDefaults.standard.set(nameField.text!, forKey: "name")
        dismiss(animated: true, completion: nil)
        
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
