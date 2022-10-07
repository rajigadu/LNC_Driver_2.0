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
var LognedUserType = ""
var newDeviceId = ""
var inServerSavedDeviceId = ""
var GOOGLE_API_KEY = "AIzaSyAK7N4kOTSAWpSlzoOQk9_dKp9Sci2sshY"
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    var bgTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0);
    lazy var viewModel = {
        DashBoardViewModel()
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AppUpdater.shared.showUpdate(withConfirmation: false)
        setupIQKeyboardManager()

        self.FireBaseAppDelegateDidFineshMethod(application : application, launchOptions: launchOptions)

        
        navigateToRespectivePage()
        
        if let GoogleKey = UserDefaults.standard.string(forKey: "Googlekeyvalue") as? String {
            GOOGLE_API_KEY = GoogleKey
        } else {
            self.getgooglekeyListAPI()
        }
        
        if GOOGLE_API_KEY != "" {
            GMSServices.provideAPIKey(GOOGLE_API_KEY)
            GMSPlacesClient.provideAPIKey(GOOGLE_API_KEY)
        }
        return true
    }
}
    extension AppDelegate {
        //MARk: -- API REQUEST CLASS DELEGATE
        //MARK: - request for Google Key
        func getgooglekeyListAPI() {
            indicator.showActivityIndicator()
            self.viewModel.requestForgetgooglekeyListAPIServices(perams: ["":""]) { success, model, error in
                if success, let UserData = model {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        if UserData.status == "1" {
                            UserDefaults.standard.set(UserData.data?.key ?? "", forKey: "Googlekeyvalue")
                            GOOGLE_API_KEY = UserData.data?.key ?? ""
                        }
                    }
                } else {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                       // self.showToast(message: error ?? "no record found.", font: .systemFont(ofSize: 12.0))
                    }
                }
            }
        }
    }


