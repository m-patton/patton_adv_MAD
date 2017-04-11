//
//  AddViewController.swift
//  lab6
//
//  Created by Mae Patton on 4/10/17.
//  Copyright © 2017 atlas. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var quoteName: UITextField!
    @IBOutlet weak var quoteField: UITextView!
    
    var addedname = String()
    var addedquote = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "savesegue"{
            if quoteName.text?.isEmpty == false {
                addedname = quoteName.text!
                addedquote = quoteField.text!
            }
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
