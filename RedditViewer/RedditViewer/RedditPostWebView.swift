//
//  RedditPostWebView.swift
//  RedditViewer
//
//  Created by JustinCaty<3 on 2/19/19.
//  Copyright © 2019 Justin. All rights reserved.
//

import UIKit
import WebKit

class RedditPostWebView: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    let url: String? = ""
    
    override func viewDidLoad() {
        let request = URLRequest(url: URL(string: "https://www.google.com")!)
        webView.load(request)
    }
}
