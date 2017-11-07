//
//  LoginController.swift
//  instame
//
//  Created by Miles Alden on 11/5/17.
//  Copyright © 2017 Miles Alden. All rights reserved.
//

import UIKit
import WebKit

class LoginController: UIViewController, WKNavigationDelegate {

    @IBOutlet var webView : WKWebView!
    @IBOutlet var mainTabBar : MainTabBarController!
    
    // Split out api components
    let clientId = "0637825256de4d9e9c969ec594b032c8"
    let redirectUri = "https://www.23andme.com"
    let logoutUrl = "https://instagram.com/accounts/logout"
    var instagramAuth = ""
    var access_token : String? = nil
    var navBarBorder : CALayer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set this after init since it relies on `self.` items.
        self.instagramAuth = "https://api.instagram.com/oauth/authorize/?client_id=\(clientId)&redirect_uri=\(redirectUri)&response_type=token"
        
        // Make navbar a little prettier
        let navBar = self.navigationController!.navigationBar
        self.navBarBorder = navBar.addBottomBorder(color: UIColor.lightGray, width: 1, inset : 5)
        

        // Compose request and load auth
        let url = URL(string:instagramAuth)
        let req = URLRequest(url: url!)
        
        webView.navigationDelegate = self
        webView.load(req)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if self.access_token != nil {
            
            // Reset access token
            self.access_token = nil
            InstaApi.shared.access_token = nil
            
            // Force a logout by url
            let url = URL(string:self.logoutUrl)
            let req = URLRequest(url: url!)
            
            webView.navigationDelegate = self
            webView.frame = CGRect(x: 0, y: 0, width: webView.frame.size.width, height: webView.frame.size.height)
            webView.load(req)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // Ensure we can log back in again using our pattern
        if webView.url?.path == "/" {
            
            let url = URL(string:instagramAuth)
            let req = URLRequest(url: url!)
            
            webView.navigationDelegate = self
            webView.load(req)
        }
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
        guard var token : String = webView.url?.fragment
            else {
                return
        }
        
        print ("Found fragment : \(token)")
        
        // Regex match to extract access token from fragment
        let _token = token.match("[0-9]+\\.[0-9]+\\.([0-9]|[a-z])+")
        self.access_token = _token.count > 0 ? _token[0] : nil
        
        // Access token found
        if var ac = self.access_token {
            
            // Prevent redirect from showing
            webView.stopLoading()
            
            print ("Print access token is : \(ac)")

            // Cache access token
            ac = NSString(string:ac).replacingOccurrences(of: "access_token=", with: "")
            InstaApi.shared.access_token = ac

            
            // Hide frame on login
            UIView.animate(withDuration: 0.125, delay: 0, options: .curveEaseOut, animations: {
                
                webView.frame = CGRect(x: 0, y: webView.frame.size.height, width: webView.frame.size.width, height: webView.frame.size.height)
                self.navBarBorder?.removeFromSuperlayer()
                
            }, completion: { (done : Bool) in
                
                self.performSegue(withIdentifier: "PushTabController", sender: self)
            })
        }
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
