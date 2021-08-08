//
//  HelpViewController.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/8/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Help"
        configure()
    }
    
    func configure() {
        if let asset = Bundle.main.url(forResource: "Help", withExtension: "pdf", subdirectory: nil, localization: nil) {
            webView.loadFileURL(asset, allowingReadAccessTo: asset)
            view.addSubview(webView)
        }
    }
}
