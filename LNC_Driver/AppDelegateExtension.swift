//
//  AppDelegateExtension.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 05/10/22.
//

import Foundation
import UIKit
import IQKeyboardManager
import FirebaseCore
import Firebase
import FirebaseMessaging


extension AppDelegate {
    func setupIQKeyboardManager(){
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().resignFirstResponder()
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
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
extension AppDelegate : MessagingDelegate{
    
    func FireBaseAppDelegateDidFineshMethod(application : UIApplication,launchOptions : [UIApplication.LaunchOptionsKey: Any]?){
        
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        
        handleNotificationWhenAppIsKilled(launchOptions)
        //remote Notifications
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, err) in
                if err != nil {
                    //Something bad happend
                } else {
                    UNUserNotificationCenter.current().delegate = self
                    //  Messaging.messaging().delegate = self
                    
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert], completionHandler: { (granted, error) in
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            })
        }else{
            let notificationSettings = UIUserNotificationSettings(types: [.badge,.sound,.alert], categories: nil)
            DispatchQueue.main.async {
                UIApplication.shared.registerUserNotificationSettings(notificationSettings)
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    
    func handleNotificationWhenAppIsKilled(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        // Check if launched from the remote notification and application is close
        
        if let remoteNotification = launchOptions?[.remoteNotification] as?  [AnyHashable : Any] {
            
            let result = remoteNotification as! Dictionary<String,AnyObject>
            
            print(result)
            
            if let dict = remoteNotification as? [String:Any] {
                if let dataDictstr = dict["gcm.notification.data"] as? String {
                    //ChatNotificationData
                    do {
                        let alertstr = try? JSONDecoder().decode([ChatNotificationData].self,from:dataDictstr.data(using:.utf8)!)
                        
                        //MARK: - Messages
                        if let ride = alertstr?[0].ride as? String, ride == "newusermessage" {
                            if let message = alertstr?[0].message as? String,
                               let userid = alertstr?[0].userid as? String, let partnerID = alertstr?[0].partnerid as? String,
                               let driver_id = alertstr?[0].driverid as? String
                            {
                                print(message,userid,driver_id,ride)
                                //self.MoveChatScreen(DriverId: driver_id)
                                self.MoveChatScreen(str_ChatType: "ToUser", userID: userid, chatType: ride,userChatNotification: "UserChat",chatFromLaunchScreen: "UserFromLaunchScreen")
                            }
                        } else if let ride = alertstr?[0].ride as? String, ride == "newdrivermessage" {
                            if let message = alertstr?[0].message as? String,
                               let userid = alertstr?[0].userid as? String, let partnerID = alertstr?[0].partnerid as? String,
                               let driver_id = alertstr?[0].driverid as? String
                            {
                                print(message,userid,driver_id,ride)
                                //self.MoveChatScreen(DriverId: driver_id)
                                self.MoveChatScreen(str_ChatType: "ToDriver", userID: driver_id, chatType: ride,userChatNotification: "PartnerChat",chatFromLaunchScreen: "PartnerFromLaunchScreen")
                            }
                        } else if let ride = alertstr?[0].ride as? String, ride == "newpartnermessage" {
                            if let message = alertstr?[0].message as? String,
                               let userid = alertstr?[0].userid as? String, let partnerID = alertstr?[0].partnerid as? String,
                               let driver_id = alertstr?[0].driverid as? String
                            {
                                print(message,userid,driver_id,ride)
                                //self.MoveChatScreen(DriverId: driver_id)
                                self.MoveChatScreen(str_ChatType: "ToPartner", userID: partnerID, chatType: ride,userChatNotification: "DriverChat",chatFromLaunchScreen: "DriverFromLaunchScreen")
                            }
                            //MARK: - accepted Rides For Driver with Role.........
                        }else if let swap_rol_partner = alertstr?[0].swap_rol_partner as? String, swap_rol_partner == "Your role is changed from driver to partner."  {
                            
                            self.acceptedRidesForDriver(withRole:"Your role is changed from driver to partner.")
                            
                            //MARK: - accepted Rides For Driver with Role.........
                        } else if let swap_rol_partner = alertstr?[0].swap_rol_partner as? String, swap_rol_partner == "Your role is changed from partner to driver."  {
                            
                            self.acceptedRidesForDriver(withRole:"Your role is changed from partner to driver.")
                        }
                        //MARK: - Rich Notifications.........
                        else if let ride = alertstr?[0].ride as? String, ride == "richnotification" {
                            self.goToUserRichNotifications()
                        }
                        //MARK: - New Ride.........
                        else if let ride = alertstr?[0].ride as? String, ride == "future_notification" {
                            self.goToDriverRideReservations()
                        }
                        
                    } catch  {
                        print("")
                    }
                }
            }
        }
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    // Push Notification
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("\n\n\n\n\n ==== FCM Token:  ",fcmToken)
        UserDefaults.standard.set(fcmToken, forKey: "FCMDeviceToken")
        connectToFcm()
    }
    
    
    
    // Push Notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("tap on on forground app",userInfo)
        
        let result = userInfo as! Dictionary<String,AnyObject>
        
        print(result)
        
        let state = UIApplication.shared.applicationState
        if let dict = userInfo as? [String:Any] {
            if let dataDictstr = dict["gcm.notification.data"] as? String {
                //ChatNotificationData
                do {
                    let alertstr = try? JSONDecoder().decode([ChatNotificationData].self,from:dataDictstr.data(using:.utf8)!)
                    
                    //MARK: - Messages
                    if let ride = alertstr?[0].ride as? String, ride == "newusermessage" {
                        if let message = alertstr?[0].message as? String,
                           let userid = alertstr?[0].userid as? String, let partnerID = alertstr?[0].partnerid as? String,
                           let driver_id = alertstr?[0].driverid as? String
                        {
                            print(message,userid,driver_id,ride)
                            //self.MoveChatScreen(DriverId: driver_id)
                            self.MoveChatScreen(str_ChatType: "ToUser", userID: userid, chatType: ride,userChatNotification: "UserChat",chatFromLaunchScreen: "UserFromLaunchScreen")
                        }
                    } else if let ride = alertstr?[0].ride as? String, ride == "newdrivermessage" {
                        if let message = alertstr?[0].message as? String,
                           let userid = alertstr?[0].userid as? String, let partnerID = alertstr?[0].partnerid as? String,
                           let driver_id = alertstr?[0].driverid as? String
                        {
                            print(message,userid,driver_id,ride)
                            //self.MoveChatScreen(DriverId: driver_id)
                            self.MoveChatScreen(str_ChatType: "ToDriver", userID: driver_id, chatType: ride,userChatNotification: "PartnerChat",chatFromLaunchScreen: "PartnerFromLaunchScreen")
                        }
                    } else if let ride = alertstr?[0].ride as? String, ride == "newpartnermessage" {
                        if let message = alertstr?[0].message as? String,
                           let userid = alertstr?[0].userid as? String, let partnerID = alertstr?[0].partnerid as? String,
                           let driver_id = alertstr?[0].driverid as? String
                        {
                            print(message,userid,driver_id,ride)
                            //self.MoveChatScreen(DriverId: driver_id)
                            self.MoveChatScreen(str_ChatType: "ToPartner", userID: partnerID, chatType: ride,userChatNotification: "DriverChat",chatFromLaunchScreen: "DriverFromLaunchScreen")
                        }
                        //MARK: - accepted Rides For Driver with Role.........
                    }else if let swap_rol_partner = alertstr?[0].swap_rol_partner as? String, swap_rol_partner == "Your role is changed from driver to partner."  {
                        
                        self.acceptedRidesForDriver(withRole:"Your role is changed from driver to partner.")
                        
                        //MARK: - accepted Rides For Driver with Role.........
                    } else if let swap_rol_partner = alertstr?[0].swap_rol_partner as? String, swap_rol_partner == "Your role is changed from partner to driver."  {
                        
                        self.acceptedRidesForDriver(withRole:"Your role is changed from partner to driver.")
                    }
                    //MARK: - Rich Notifications.........
                    else if let ride = alertstr?[0].ride as? String, ride == "richnotification" {
                        self.goToUserRichNotifications()
                    }
                    //MARK: - New Ride.........
                    else if let ride = alertstr?[0].ride as? String, ride == "future_notification" {
                        self.goToDriverRideReservations()
                    }
                    
                } catch  {
                    print("")
                }
            }
        }
        
        completionHandler(UIBackgroundFetchResult.newData)
        
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().appDidReceiveMessage(userInfo)
    }
    
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print(error.localizedDescription)
        print("Not registered notification")
    }
    
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        if let refreshedToken = Messaging.messaging().fcmToken {
            print("InstanceID token: \(refreshedToken)")
            newDeviceId = refreshedToken
            print(newDeviceId)
            Messaging.messaging().apnsToken = deviceToken
            print("Token generated: ", refreshedToken)
        }
        UserDefaults.standard.set(newDeviceId, forKey:"FCMDeviceToken")
        UserDefaults.standard.synchronize()
        //        connectToFcm()
    }
    
    func connectToFcm() {
        Messaging.messaging().isAutoInitEnabled = true
        //  Messaging.messaging().shouldEstablishDirectChannel = false
        
        //messaging().shouldEstablishDirectChannel = true
        if let token = Messaging.messaging().fcmToken {
            print("\n\n\n\n\n\n\n\n\n\n ====== TOKEN DCS: " + token)
        }
    }
    
    //    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    //
    //    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        //      let dataDict:[String: String] = ["token": fcmToken ?? ""]
        //      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        
        
        print("Firebase registration token: \(fcmToken)")
        if let fcmTokenstr = fcmToken {
            newDeviceId = fcmTokenstr
            UserDefaults.standard.set(newDeviceId, forKey:"device_id")
            UserDefaults.standard.set(newDeviceId, forKey:"FCMDeviceToken")
            
            UserDefaults.standard.synchronize()
            let devicetoken : String!
            devicetoken = UserDefaults.standard.string(forKey:"device_id") as String?
            print(devicetoken)
        }
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    
    //    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
    //        print("Received data message: \(remoteMessage.appData)")
    //    }
    
    @available(iOS 10.0, *)
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let content = notification.request.content
        
        print("\(content.userInfo)")
        print("GOT A NOTIFICATION")
        
        let result = content.userInfo as! Dictionary<String,AnyObject>
        
        print(result)
        
        let state = UIApplication.shared.applicationState
        
        if state == .background  || state == .inactive {
            
            if let dict = content.userInfo as? [String:Any] {
                if let dataDictstr = dict["gcm.notification.data"] as? String {
                    //ChatNotificationData
                    do {
                        let alertstr = try? JSONDecoder().decode([ChatNotificationData].self,from:dataDictstr.data(using:.utf8)!)
                        
                        //MARK: - Messages
                        if let ride = alertstr?[0].ride as? String, ride == "newusermessage" {
                            if let message = alertstr?[0].message as? String,
                               let userid = alertstr?[0].userid as? String,
                               let driver_id = alertstr?[0].driverid as? String
                            {
                                print(message,userid,driver_id,ride)
                                //self.MoveChatScreen(DriverId: driver_id)
                                self.MoveChatScreen(str_ChatType: "ToUser", userID: userid, chatType: ride,userChatNotification: "UserChat",chatFromLaunchScreen: "UserFromLaunchScreen")
                            }
                        } else if let ride = alertstr?[0].ride as? String, ride == "newdrivermessage" {
                            if let message = alertstr?[0].message as? String,
                               let userid = alertstr?[0].userid as? String,
                               let driver_id = alertstr?[0].driverid as? String
                            {
                                print(message,userid,driver_id,ride)
                                //self.MoveChatScreen(DriverId: driver_id)
                                self.MoveChatScreen(str_ChatType: "ToDriver", userID: driver_id, chatType: ride,userChatNotification: "PartnerChat",chatFromLaunchScreen: "PartnerFromLaunchScreen")
                            }
                        } else if let ride = alertstr?[0].ride as? String, ride == "newpartnermessage" {
                            if let message = alertstr?[0].message as? String,
                               let userid = alertstr?[0].userid as? String, let partnerID = alertstr?[0].partnerid as? String,
                               let driver_id = alertstr?[0].driverid as? String
                            {
                                print(message,userid,driver_id,ride)
                                //self.MoveChatScreen(DriverId: driver_id)
                                self.MoveChatScreen(str_ChatType: "ToPartner", userID: partnerID, chatType: ride,userChatNotification: "DriverChat",chatFromLaunchScreen: "DriverFromLaunchScreen")
                            }
                            //MARK: - accepted Rides For Driver with Role.........
                        }else if let swap_rol_partner = alertstr?[0].swap_rol_partner as? String, swap_rol_partner == "Your role is changed from driver to partner."  {
                            
                            self.acceptedRidesForDriver(withRole:"Your role is changed from driver to partner.")
                            
                            //MARK: - accepted Rides For Driver with Role.........
                        } else if let swap_rol_partner = alertstr?[0].swap_rol_partner as? String, swap_rol_partner == "Your role is changed from partner to driver."  {
                            
                            self.acceptedRidesForDriver(withRole:"Your role is changed from partner to driver.")
                        }
                        //MARK: - Rich Notifications.........
                        else if let ride = alertstr?[0].ride as? String, ride == "richnotification" {
                            self.goToUserRichNotifications()
                        }
                        //MARK: - New Ride.........
                        else if let ride = alertstr?[0].ride as? String, ride == "future_notification" {
                            self.goToDriverRideReservations()
                        }
                        
                        
                    } catch  {
                        print("")
                    }
                }
            }
            
        }else if state == .active {
            
            
        }
        
        if self.window?.rootViewController?.topMostViewController() is ChatViewController {
            completionHandler([])
        } else {
            completionHandler([.alert, .badge, .sound])
        }
        
        completionHandler([.alert, .sound])
        
    }
    
    func saveChatIDS(ChatID : String){
        let chatdata = UserDefaults.standard.value(forKey: "ChatIDArray") as? [String]
        print(chatdata)
        if chatdata?.count ?? 0 <= 0{
            var dataArray = [String]()
            dataArray.append(ChatID)
            UserDefaults.standard.setValue(dataArray, forKey: "ChatIDArray")
        }else{
            print(chatdata)
            var chatlistIds = [String]()
            chatlistIds = chatdata ?? []
            chatlistIds.append(ChatID)
            UserDefaults.standard.setValue(chatlistIds, forKey: "ChatIDArray")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "IGotChatMSG"), object: nil,userInfo: ["ChatID" : ChatID])
    }
    
    func alerfunc(msg : String){
        let alert = UIAlertController(title: kApptitle, message:msg, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
// Extension
extension AppDelegate {
    // Move to Chat Screen
    func MoveChatScreen(str_ChatType: String, userID: String, chatType: String,userChatNotification: String,chatFromLaunchScreen: String){
        var navigation = UINavigationController()
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
        let nxtVC : ChatViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        nxtVC.userChatNotification = userChatNotification
        nxtVC.chatFromLaunchScreen = chatFromLaunchScreen
        nxtVC.isTappedNotification = true
        nxtVC.recevierId = userID
        nxtVC.str_ChatType = str_ChatType
        nxtVC.vcCmgFrom = "AppDelegate"
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigation = UINavigationController(rootViewController: nxtVC)
        
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
     }
    
    // Move to ride history
    func goToDriverRideReservations() {
        var navigation = UINavigationController()
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
        
        let nxtVC : RideReservationsViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "RideReservationsViewController") as! RideReservationsViewController
        nxtVC.vcCmgFrom = "AppDelegate"
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigation = UINavigationController(rootViewController: nxtVC)
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
    }
    
    // Move to rich Notifications
    func goToUserRichNotifications() {
        var navigation = UINavigationController()
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "DashBoard", bundle: nil)
         let nxtVC : NotificationViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        nxtVC.vcCmgFrom = "AppDelegate"
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigation = UINavigationController(rootViewController: nxtVC)
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
     }
    
    // Move to Feed back Page
    func acceptedRidesForDriver(withRole: String) {
        var navigation = UINavigationController()
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
        let nxtVC : AcceptedRidesInfoViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "AcceptedRidesInfoViewController") as! AcceptedRidesInfoViewController
        nxtVC.str_DriverRole = withRole
        nxtVC.vcCmgFrom = "AppDelegate"
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navigation = UINavigationController(rootViewController: nxtVC)
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
    }
}
/*
 [AnyHashable("aps"): {
     alert =     {
         title = "New Ride Request.";
     };
     sound = default;
 }, AnyHashable("google.c.a.e"): 1, AnyHashable("gcm.notification.text"): A Reservation has been placed please open the app if you would like to accept., AnyHashable("google.c.sender.id"): 12677790788, AnyHashable("google.c.fid"): fO8i6xKd406VkCO865XtOw, AnyHashable("gcm.message_id"): 1667666306073671, AnyHashable("gcm.notification.data"): [{
 "userid":"701",
 "start_location":"KommalaPadu,AndhraPradesh523303,India",
 "end_location":"Addanki,AndhraPradesh523201,India",
 "ride":"future_notification",
 "message":"A Reservation has been placed please open the app if you would like to accept.",
 "ride_id":"24249"}]]
 
 
 
 
 
 ["aps": {
     alert =     {
         title = "New Message";
     };
     sound = default;
 }, "google.c.fid": fO8i6xKd406VkCO865XtOw, "gcm.notification.text": sdfasdfsad, "gcm.notification.data": [{
                     "message":"sdfasdfsad",
                     "driverid":"24",
                     "user_id":"701",
                     "ride":"newusermessage"}], "google.c.sender.id": 12677790788, "google.c.a.e": 1, "gcm.message_id": 1667666877913914]
 */
