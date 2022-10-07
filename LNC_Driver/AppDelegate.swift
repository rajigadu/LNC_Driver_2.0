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
let GOOGLE_API_KEY = "AIzaSyAK7N4kOTSAWpSlzoOQk9_dKp9Sci2sshY"
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    var bgTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0);

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AppUpdater.shared.showUpdate(withConfirmation: false)

        GMSServices.provideAPIKey(GOOGLE_API_KEY)
        GMSPlacesClient.provideAPIKey(GOOGLE_API_KEY)
        setupIQKeyboardManager()

        self.FireBaseAppDelegateDidFineshMethod(application : application, launchOptions: launchOptions)

        
        navigateToRespectivePage()
        return true
    }
}
