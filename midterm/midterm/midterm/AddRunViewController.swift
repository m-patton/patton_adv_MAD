//
//  AddRunViewController.swift
//  midterm
//
//  Created by Mae Patton on 3/16/17.
//  Copyright © 2017 atlas. All rights reserved.
//

import UIKit

class AddRunViewController: UIViewController {

    @IBOutlet weak var runTextField: UITextField!
    
    var addedRun = String()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "doneSegue"{
            if ((runTextField.text?.isEmpty) == false){
                addedRun=runTextField.text!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
