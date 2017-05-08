//
//  moodViewController.swift
//  p1m3
//
//  Created by Mae Patton on 3/12/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class moodViewController: UIViewController {
    var selectedIndex = -1
    
    var moodArray = [Int]() //this will hold mood information for graph
    var dateArray = [String]() //this will keep track of dates
    var dateStr: String!
    var moodNum: Int!

    @IBOutlet weak var moodImage: UIImageView!
    @IBOutlet weak var moodLabel: UILabel!
    
    @IBOutlet weak var moodSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        dateStr = dateFormatter.string(from: date as Date)
        moodNum = 7
        moodLabel.text = String(moodNum)
        
        let userDefaults = UserDefaults.standard
        guard let dates = userDefaults.array(forKey: "dates") as? [String] else {
            return
        }
        guard let data = userDefaults.array(forKey: "moods") as? [Int] else {
            return
        }
        dateArray = dates
        moodArray = data
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppUtility.lockOrientation(.portrait)
        
        let userDefaults = UserDefaults.standard
        guard let dates = userDefaults.array(forKey: "dates") as? [String] else {
            return
        }
        guard let data = userDefaults.array(forKey: "moods") as? [Int] else {
            return
        }
        dateArray = dates
        moodArray = data
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }
    

    
    @IBAction func changeMoodSlider(_ sender: UISlider) {
        moodNum = Int(sender.value)
        moodLabel.text = String(moodNum)
        if (moodNum < 3) {
            moodImage.image = UIImage(named:"1")
        }
        else if (moodNum >= 3 && moodNum < 5) {
            moodImage.image = UIImage(named:"2")
        }
        else if (moodNum >= 5 && moodNum < 7) {
            moodImage.image = UIImage(named:"3")
        }
        else if (moodNum >= 7 && moodNum < 9) {
            moodImage.image = UIImage(named:"4")
        }
        else{
            moodImage.image = UIImage(named:"5")
        }
        
    }
    
    @IBAction func addMoodButton(_ sender: UIButton) {
        moodArray.append(moodNum)
        dateArray.append(dateStr)
        print(moodArray)
        print(dateArray)
        saveMoodArray()
    }
    
    func saveMoodArray() {
        UserDefaults.standard.set(moodArray, forKey: "moods")
        UserDefaults.standard.set(dateArray, forKey: "dates")
        UserDefaults.standard.synchronize()
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
