//
//  EmployeeGuideLinesViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 06/10/22.
//

import Foundation
import UIKit
import WebKit

class EmployeeGuideLinesViewController: UIViewController {

    //MARK: - Class outlets
    @IBOutlet weak var webview_Ref:WKWebView!
    
    //MARK: - Class Propeties
    var str_ActionComingFrom: String?
    lazy var viewModel = {
        Terms_PrivacyViewModel()
    }()
    var guideLinesURL = ""
    
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.swipeRight()
        self.title = str_ActionComingFrom
        var websiteUrl: URL?
        webview_Ref.isOpaque = false
        webview_Ref.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        if str_ActionComingFrom == "Terms & Conditions" {
            websiteUrl = URL(string: "\(API_URl.API_TERMSCONDITIONS_URL)")
        } else if str_ActionComingFrom == "Privacy Policy" {
            websiteUrl = URL(string: "\(API_URl.API_PRIVACYPOLICY_URL)")
        } else if str_ActionComingFrom == "Help" {
            websiteUrl = URL(string: "\(API_URl.API_HELP_URL)")
        } else if str_ActionComingFrom == "Employee Guidelines" {
            self.title = "Guidelines"
            self.GetEmplyeeGuideLinesPDF()
        }
        DispatchQueue.global(qos: .default).sync(execute: { [self] in
            if let webUrl = websiteUrl {
                let urlRequest = URLRequest(url: webUrl)
                webview_Ref.navigationDelegate = self
                webview_Ref.load(urlRequest)
            }
        })
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openMenuBtnref(_ sender: Any) {
        self.navigateToSideMenu()
    }
    
    //MARK: - Class Actions
    
    func LoadGuideLineURL(){
        if guideLinesURL == "" || guideLinesURL == "No Pdf Found" {
            //webview_Ref.
        } else {
            var websiteUrl: URL?
            webview_Ref.isOpaque = false
            webview_Ref.backgroundColor = UIColor.white.withAlphaComponent(0.1)
            if str_ActionComingFrom == "Employee Guidelines" {
                websiteUrl = URL(string: "\(API_URl.API_HELP_URL)")
            }
            DispatchQueue.global(qos: .default).sync(execute: { [self] in
                if let webUrl = websiteUrl {
                    let urlRequest = URLRequest(url: webUrl)
                    webview_Ref.navigationDelegate = self
                    webview_Ref.load(urlRequest)
                }
            })
        }
    }
}
extension EmployeeGuideLinesViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started to load")
        indicator.showActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading")
        indicator.hideActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        indicator.hideActivityIndicator()
    }
}
extension EmployeeGuideLinesViewController {
    
    //MARK: - Api Intigration
    func GetEmplyeeGuideLinesPDF(){
            indicator.showActivityIndicator()
        self.viewModel.requestForGetEmplyeeGuideLinesPDFServices(perams: [:]) { success, model, error in
                if success, let UserData = model {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        if UserData.loginStatus == "1" {
                        self.guideLinesURL = UserData.pdf_name ?? ""
                        self.LoadGuideLineURL()
                        } else {
                            self.showToast(message: UserData.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
                        }
                    }
                } else {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        self.showToast(message: error ?? I18n.SomethingWentWrong, font: .systemFont(ofSize: 12.0))
                    }
                }
            }
       
    }
}



