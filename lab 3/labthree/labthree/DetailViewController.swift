//
//  DetailViewController.swift
//  labthree
//
//  Created by Mae Patton on 3/7/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBAction func share(_ sender: UIBarButtonItem) {
        var imageArray = [UIImage]()
        imageArray.append(imageView.image!)
        let shareScreen = UIActivityViewController(activityItems:
            imageArray, applicationActivities: nil)
        shareScreen.modalPresentationStyle = .popover
        shareScreen.popoverPresentationController?.barButtonItem = sender as
        UIBarButtonItem
        present(shareScreen, animated: true, completion: nil)
    }
    
    var imageName : String?
    
    /*
    @IBAction func share(_ sender: UIBarButtonItem) {
        var imageArray = [UIImage]()
        imageArray.append(imageView.image!)
        let shareScreen = UIActivityViewController(activityItems:
            imageArray, applicationActivities: nil)
        shareScreen.modalPresentationStyle = .popover
        shareScreen.popoverPresentationController?.barButtonItem = sender as
        UIBarButtonItem
        present(shareScreen, animated: true, completion: nil)
    }*/
    override func viewWillAppear(_ animated: Bool) { if let name = imageName {
        imageView.image = UIImage(named: name) }
    }

    @IBOutlet weak var imageView: UIImageView!
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
