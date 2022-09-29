//
//  AppDelegate.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 07/09/22.
//

import UIKit
import CoreData
import GooglePlaces
import GoogleMaps
let GOOGLE_API_KEY = "AIzaSyAK7N4kOTSAWpSlzoOQk9_dKp9Sci2sshY"
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(GOOGLE_API_KEY)
        GMSPlacesClient.provideAPIKey(GOOGLE_API_KEY)
        navigateToRespectivePage()
        return true
    }
}

/*
 //MARK: - Class outlets
 //MARK: - Class Propeties
 //MARK: - View life cycle
 //MARK: - Class Actions
 */

extension AppDelegate {
    func navigateToRespectivePage(){
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]

        if UserDefaults.standard.bool(forKey: "IsUserLogined") {
            moveToDashBoard()
        }else {
            MoveToLogin()
        }
    }
    
    func MoveToLogin(){
        var navigation = UINavigationController()
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
        
        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigation = UINavigationController(rootViewController: initialViewControlleripad)
        
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        
    }
    
    func moveToDashBoard(){
        var navigation = UINavigationController()
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "DashBoard", bundle: nil)
        
        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "DashBoardViewController") as! DashBoardViewController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigation = UINavigationController(rootViewController: initialViewControlleripad)
        
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        
    }
}
