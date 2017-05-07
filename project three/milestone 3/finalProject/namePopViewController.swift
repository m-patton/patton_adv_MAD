//
//  namePopViewController.swift
//  p1m3
//
//  Created by Mae Patton on 3/13/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class namePopViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func dismissP(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveName(_ sender: UIButton) {
        UserDefaults.standard.set(nameField.text!, forKey: "name")
        dismiss(animated: true, completion: nil)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
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
