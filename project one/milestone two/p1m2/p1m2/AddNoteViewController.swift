//
//  AddNoteViewController.swift
//  p1m2
//
//  Created by Mae Patton on 3/7/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var text1: UITextView!
    
    @IBOutlet weak var text2: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(dateLabel.text == "date"){
            setDate()
        }
        
        text1.delegate = self
        text2.delegate = self
       
        // Do any additional setup after loading the view.
    }
    
    func setDate(){
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM,dd, y"
        let dateStr = dateFormatter.string(from: date as Date)
        dateLabel.text = dateStr
        
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
