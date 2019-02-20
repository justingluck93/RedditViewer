//
//  RedditPostWebView.swift
//  RedditViewer
//
//  Created by Justin on 2/19/19.
//  Copyright © 2019 Justin. All rights reserved.
//

import UIKit
import WebKit

class RedditPostWebView: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var url: String?
    
    override func viewDidLoad() {
        guard let urlString = url else { return }
        let request = URLRequest(url: URL(string: "https://www.reddit.com\(urlString)")!)
            webView.load(request)
    }
}
