//
//  WebViewController.swift
//  News
//
//  Created by Jorge Casariego on 22/2/16.
//  Copyright © 2016 Developer Inspirus. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate
{
    var publisher: Publisher!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet private weak var webView: UIWebView!
    
    private var hasFinishLoading = false
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = publisher.title
        webView.delegate = self
        
        let pageUrl = NSURL(string: publisher.url)!
        let request = NSURLRequest(URL: pageUrl)
        
        webView.loadRequest(request)
        navigationController?.hidesBarsOnSwipe = true
        
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        hasFinishLoading = false
        updateProgress()
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()){
            [weak self] in
            if let _self = self {
                _self.hasFinishLoading = true
            }
        }
    }
    
    deinit {
        webView.stopLoading()
        webView.delegate = nil
    }
    
    func updateProgress()
    {
        if progressView.progress >= 1 {
            progressView.hidden = true
        } else {
            if hasFinishLoading {
                progressView.progress += 0.002
            } else {
                if progressView.progress <= 0.3 {
                     progressView.progress += 0.004
                } else if progressView.progress <= 0.6 {
                    progressView.progress += 0.002
                } else if progressView.progress <= 0.9 {
                    progressView.progress += 0.001
                } else if progressView.progress <= 0.94 {
                    progressView.progress += 0.0001
                } else {
                    progressView.progress += 0.9401
                }
            }
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.008 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()){
            [weak self] in
            if let _self = self {
                _self.updateProgress()
            }
        }

    }
    
}
