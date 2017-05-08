//
//  mainViewController.swift
//  p1m3
//
//  Created by Mae Patton on 3/12/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import UIKit
import JBChart
import Firebase
import FirebaseDatabase

//CHART STUFF FROM JawBone's github

class mainViewController: UIViewController, JBLineChartViewDataSource, JBLineChartViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPageViewControllerDelegate {

    @IBOutlet weak var lineGraph: JBLineChartView!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    var chartLegs = ["0","0","0","0","0","0","0"]//= [String]()
    var chartDatas = [0,0,0,0,0,0,0]//[Int]()
    var chartLegFull = [String]()
    var chartDataFull = [Int]()
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///SAVE INITIAL IMAGE
        AppUtility.lockOrientation(.portrait)
        /*
        let imageData:NSData = UIImagePNGRepresentation(userImage.image!)! as NSData
        UserDefaults.standard.set(imageData, forKey: "savedImage")*/
        
        if let imgdata = UserDefaults.standard.object(forKey: "savedImage"){
            let imgdata2 = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            userImage.image=UIImage(data: imgdata2 as Data)
        }
        
        view.backgroundColor = UIColor.white
        
        lineGraph.backgroundColor = UIColor(red: 250/250, green: 250/250, blue: 250/250, alpha: 8/10)
        lineGraph.delegate = self
        lineGraph.dataSource = self
        lineGraph.minimumValue = 0
        lineGraph.maximumValue = 10
        
        lineGraph.reloadData()
        lineGraph.setState(.collapsed, animated: false)
        
        
        if let name = UserDefaults.standard.string(forKey: "name")
            {
            //UserDefaults.standard.set(nameLabel.text!, forKey: "name")
            nameLabel.text = "Hello, " + name
        }else {
            nameLabel.text = "Add Name"
        }
        let userDefaults = UserDefaults.standard
        guard let dates = userDefaults.array(forKey: "dates") as? [String] else {
            return
        }
        guard let data = userDefaults.array(forKey: "moods") as? [Int] else {
            return
        }
        chartLegFull = dates
        chartDataFull = data
        //get last part of array or all of array if less than seven entries
        var size = Int(chartLegFull.count)
        size = size - 1
        chartLegFull = chartLegFull.reversed()
        chartDataFull = chartDataFull.reversed()
        if(chartLegFull.count >= 7){
            chartLegs[0...6] = chartLegFull[0...6]
            chartDatas[0...6] = chartDataFull[0...6]
        }else{
            chartLegs[0...size] = chartLegFull[0...size]
            chartDatas[0...size] = chartDataFull[0...size]
        }
        print(chartDatas)
        chartLegs = chartLegs.reversed()
        chartDatas = chartDatas.reversed()
        print(chartDatas)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
        
        
        super.viewDidAppear(animated)
        
        AppUtility.lockOrientation(.portrait) /// LOCKS SCREEN
        
        ///GET IN IMAGE
        if let imgdata = UserDefaults.standard.object(forKey: "savedImage"){
            let imgdata2 = UserDefaults.standard.object(forKey: "savedImage") as! NSData
            userImage.image=UIImage(data: imgdata2 as Data)
        }
        
        
       
        
        if(chartLegFull.count > 0){
        infoLabel.text = "press on the dots to see info"
        }
        else{
            infoLabel.text = "you have no mood data to display"
        }
        
        lineGraph.reloadData()
        lineGraph.setState(.collapsed, animated: false)
        
        if let name = UserDefaults.standard.string(forKey: "name")
        {
            nameLabel.text = "Hello, " + name
        }else {
            nameLabel.text = "Add Name" //if the user hasnt added thair name yet
        }

        
        let userDefaults = UserDefaults.standard
        guard let dates = userDefaults.array(forKey: "dates") as? [String] else {
            return
        }
        guard let data = userDefaults.array(forKey: "moods") as? [Int] else {
            return
        }
        chartLegFull = dates
        chartDataFull = data
        
        //SO i need the array to only be the last seven elements added... there has to be a better way to do this
        var size = Int(chartLegFull.count)
        size = size - 1
        chartLegFull = chartLegFull.reversed()
        chartDataFull = chartDataFull.reversed()
        if(chartLegFull.count >= 7){
            chartLegs[0...6] = chartLegFull[0...6]
            chartDatas[0...6] = chartDataFull[0...6]
        }else{
            chartLegs[0...size] = chartLegFull[0...size]
            chartDatas[0...size] = chartDataFull[0...size]
        }
        print(chartDatas)
        chartLegs = chartLegs.reversed()
        chartDatas = chartDatas.reversed()
        print(chartDatas)
        
        var timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(mainViewController.showChart), userInfo: nil, repeats: false)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait)
        
        var footerView = UIView(frame: CGRect(x: 0, y: 0, width: lineGraph.frame.width, height: 16))
        
        print("viewDidLoad: \(lineGraph.frame.width)")
        
        var leftAx = UILabel(frame: CGRect(x: 0, y: 0, width: lineGraph.frame.width/2 - 8, height: 16))
        leftAx.textColor = UIColor.black
        leftAx.font = UIFont(name: "Avenir", size: 12)
        if chartLegs.count > 0 {
            if chartLegs.count < 7  {
                leftAx.text = "\(chartLegs[0])"
            }
            else{
                leftAx.text = "\(chartLegs[chartLegs.count - 7])"
            }
        }else{
            leftAx.text = ""
        }
        
        var rightAx = UILabel(frame: CGRect(x: lineGraph.frame.width/2 - 8, y: 0, width: lineGraph.frame.width/2 - 8, height: 16))
        rightAx.textColor = UIColor.black
        rightAx.font = UIFont(name: "Avenir", size: 12)
        //I WANT IT TO GET THE LAST SEVEN ELEMENTS
        if chartLegs.count > 0 {
            rightAx.text = "\(chartLegs[chartLegs.count - 1])"
        }else{
            rightAx.text = ""
        }
        rightAx.textAlignment = NSTextAlignment.right
        
        footerView.addSubview(leftAx)
        footerView.addSubview(rightAx)
        
        var header = UILabel(frame: CGRect(x: 0, y: 0, width: lineGraph.frame.width, height: 50))
        header.textColor = UIColor.black
        header.font = UIFont(name: "Avenir", size: 18)
        header.text = "Mood Entries"
        header.textAlignment = NSTextAlignment.center
        lineGraph.footerView = footerView
        lineGraph.headerView = header
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideChart()
    }
    
    func hideChart() {
        lineGraph.setState(.collapsed, animated: true)
    }
    
    func showChart() {
        lineGraph.setState(.expanded, animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func numberOfLines(in lineChartView: JBLineChartView!) -> UInt {
        return 2
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        if(chartDatas.count<7){
            return UInt(chartDatas.count)
        }else{
            return 7
        }
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        
        return CGFloat(chartDatas[Int(horizontalIndex)])
    }
    //THIS IS THE LINE COLOR OF THE CHART
    func lineChartView(_ lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        if (lineIndex == 0) {
            return UIColor.white //this will have dots
        } else if (lineIndex == 1) {
            return UIColor(red: 159/255, green: 134/255, blue: 160/255, alpha: 8/10) //this will have dots
        }
        
        return UIColor.white
    }
    //THIS FUNCTION ALLOWS DOTS TO BE SHOWN
    func lineChartView(_ lineChartView: JBLineChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        if (lineIndex == 0) { return true }
        else if (lineIndex == 1) { return false }
        
        return false
    }
    //COLOR OF THE DOT
    func lineChartView(_ lineChartView: JBLineChartView!, colorForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 7/10)
        //return UIColor(red: 160/255, green: 194/255, blue: 200/255, alpha: 10/10)
    }
    //THIS CHANGES LINES FROM JAGGED TO CURVED
    func lineChartView(_ lineChartView: JBLineChartView!, smoothLineAtLineIndex lineIndex: UInt) -> Bool {
        if (lineIndex == 0) { return false }
        else if (lineIndex == 1) { return true }
        
        return true
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, didSelectLineAt lineIndex: UInt, horizontalIndex: UInt) {
        
        let data = chartDatas[Int(horizontalIndex)]
        let key = chartLegs[Int(horizontalIndex)]
        infoLabel.text = "Mood on \(key): \(data)/10"
    }
    
    func didDeselectLine(in lineChartView: JBLineChartView!) {
        infoLabel.text = ""
    }
    //FILL IN PARTS OF GRAPH BELOW LINE WITH COLOR
    func lineChartView(_ lineChartView: JBLineChartView!, fillColorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        
        if (lineIndex == 0) {
            //return UIColor(red: 160/255, green: 194/255, blue: 200/255, alpha: 7/10) //THIS IS THE FILL COLOR BELOW
            return UIColor.clear
        }
        
        return UIColor.clear
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
