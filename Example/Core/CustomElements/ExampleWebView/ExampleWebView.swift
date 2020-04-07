//
//  ExampleWebView.swift
//  Example
//
//  Created by Data Kondzhariia on 5/3/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import WebKit

@objc protocol ExampleWebViewDelegate {
    
    @objc optional func exampleWebViewDidFinish(_ exampleWebView: ExampleWebView)
    @objc optional func exampleWebViewDidReloadAfterCalculationOfHeight(_ exampleWebView: ExampleWebView)
}

class ExampleWebView: UIView {
    
    public var delegate: ExampleWebViewDelegate?
    public var contentHeight: CGFloat = 0
    
    @IBInspectable public var scrollEnabled: Bool = true {
        didSet {
            checkScrollEnabled()
        }
    }

    lazy var webView: WKWebView = {
        
        guard let path = R.file.infoAgreementCss.path(), let cssString = try? String(contentsOfFile: path).components(separatedBy: .newlines).joined() else {
                return WKWebView()
        }
        
        let source = """
        var style = document.createElement('style');
        style.innerHTML = '\(cssString)';
        var head = document.getElementsByTagName('head')[0];
        var meta = document.createElement('meta');
        meta.name = 'viewport';
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, shrink-to-fit=no'
        head.appendChild(style);
        head.appendChild(meta);
        """
        
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let userContentController = WKUserContentController()
        userContentController.addUserScript(userScript)
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 0)
        let webView = WKWebView(frame: frame, configuration: configuration)
        webView.navigationDelegate = self
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        
        return webView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addFullsizeSubview(webView)
    }
}

// MARK: - Private Method
extension ExampleWebView {
    
    private func checkScrollEnabled() {
        
        if scrollEnabled {
            webView.scrollView.isScrollEnabled = true
        } else {
            webView.scrollView.isScrollEnabled = false
        }
    }
}

// MARK: - Public Method
extension ExampleWebView {

    public func loadHTMLContent(_ htmlContent: String) {
        webView.loadHTMLString(htmlContent, baseURL: Bundle.main.bundleURL)
    }
}

// MARK: - WKNavigation Delegate
extension ExampleWebView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        delegate?.exampleWebViewDidFinish?(self)
        
        self.webView.evaluateJavaScript("document.readyState", completionHandler: { [weak self] complete, error in
            
            guard complete != nil else {
                return
            }
            
            self?.webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { height, error in
                
                self?.contentHeight = height as! CGFloat
                
                guard let exampleView = self else {
                    return
                }
                
                self?.delegate?.exampleWebViewDidReloadAfterCalculationOfHeight?(exampleView)
            })
        })        
    }
}
