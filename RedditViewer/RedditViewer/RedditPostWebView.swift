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
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    var url: String?
    
    override func viewDidLoad() {
        guard let urlString = url else { return }
        self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
        let request = URLRequest(url: URL(string: "https://www.reddit.com\(urlString)")!)
            webView.load(request)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            if webView.isLoading {
                loadingView.startAnimating()
            } else {
                loadingView.stopAnimating()
                loadingView.isHidden = true
            }
        }
    }
}
