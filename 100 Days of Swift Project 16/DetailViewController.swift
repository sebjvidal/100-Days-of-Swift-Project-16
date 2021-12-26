//
//  DetailViewController.swift
//  100 Days of Swift Project 16
//
//  Created by Seb Vidal on 22/12/2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    var capital: Capital!
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupWebView()
    }
    
    func setupNavBar() {
        title = capital.title
    }

    func setupWebView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.load(URLRequest(url: URL(string: capital.url)!))
        
        view = webView
    }
    
}
