//
//  DetailViewController.swift
//  labfour
//
//  Created by Mae Patton on 3/20/17.
//  Copyright © 2017 atlas. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webSpinner: UIActivityIndicatorView!
    var detailItem: AnyObject? {
        didSet {
            self.configureView()
        }
    }
    

    @IBOutlet weak var webView: UIWebView!

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    func loadWebPage(_ urlString: String){
        //the urlString should be a propery formed url //creates a NSURL object
        let url = URL(string: urlString)
        //create a NSURLRequest object
        let request = URLRequest(url: url!)
        //load the NSURLRequest object in our web view
        webView.loadRequest(request)
    }


    func configureView() {
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
                loadWebPage(detail.description)
            }
        }
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("start load")
        webSpinner.startAnimating()
    }
    
    //UIWebViewDelegate method that is called when a web page loads successfully
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("stop load")
        webSpinner.stopAnimating()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

