//
//  DashBoardViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 15/09/22.
//

import UIKit
import SideMenu
import GoogleMaps
import GooglePlaces

class DashBoardViewController: UIViewController {

    //MARK: - Class outlets
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var lbl_FutureRideItimationRef: UILabel!
    @IBOutlet weak var NextRideTimeShowHeightref: NSLayoutConstraint!
    @IBOutlet weak var NextRideTimeShowViewref: UIView!
    //MARK: - Class Propeties
    var locationManager = CLLocationManager()
    let didFindMyLocation = false
    var str_UserCurrentLocationAddress = ""
    var str_UserCurrentLocationLongitude = ""
    var str_UserCurrentLocationLatitude = ""
    var str_UserCurrentLocationCity = ""
    let getLocation = GetLocation()
     var str_AppVersion = ""
     var str_DerviceToken = ""
    var str_Version = ""

    lazy var viewModel = {
        DashBoardViewModel()
    }()
    lazy var viewModel2 = {
        CancelRideViewModel()
    }()
    lazy var viewModel3 = {
        OngoingRideDetailsViewModel()
    }()
    
    lazy var viewModel4 = {
        ChatViewModel()
    }()
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NextRideTimeShowViewref.isHidden = true
        NextRideTimeShowHeightref.constant = 0
        str_DerviceToken = UserDefaults.standard.string(forKey: "FCMDeviceToken") ?? ""
        str_Version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
       // setupSideMenu()
        self.swipeRight()
        self.mapView.isMyLocationEnabled = true
        self.str_AppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""

        do {
              // Set the map style by passing the URL of the local file.
              if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                  self.mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
              } else {
                  NSLog("Unable to find style.json")
              }
          } catch {
              NSLog("One or more of the map styles failed to load. \(error)")
          }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initializeTheLocationManager()
    }
    
    //MARK: - Class Actions
    
    @IBAction func setupSideMenu(_ sender : Any){
        self.navigateToSideMenu()
        //fatalError("Crash was triggered")

    }
 
    @IBAction func openRichNotificationBtn(_ sender: Any) {
        self.movetonextvc(id: "NotificationViewController", storyBordid: "DashBoard", animated: true)
    }
    
    func initializeTheLocationManager() {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
        if askEnableLocationService() == "YES" {
            getLocation.run { [self] in
                if let location = $0 {
                    print("location = \(location.coordinate.latitude) \(location.coordinate.longitude)")
                    let CurrentLatitudeValue = location.coordinate.latitude
                    let CurrentLongitudeValue = location.coordinate.longitude
                    self.str_UserCurrentLocationLatitude = String(CurrentLatitudeValue)
                    self.str_UserCurrentLocationLongitude = String(CurrentLongitudeValue)
                    CurrentLatitude = String(CurrentLatitudeValue)
                    CurrentLongitude = String(CurrentLongitudeValue)
                    let location = CLLocation(latitude: CurrentLatitudeValue, longitude: CurrentLongitudeValue)
                    CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                        
                        guard let placemark = placemarks?.first else {
                            let errorString = error?.localizedDescription ?? "Unexpected Error"
                            print("Unable to reverse geocode the given location. Error: \(errorString)")
                            return
                        }
                        
                        let reversedGeoLocation = ReversedGeoLocation(with: placemark)
                        print(reversedGeoLocation.formattedAddress)
                        self.str_UserCurrentLocationAddress = reversedGeoLocation.formattedAddress
                        self.str_UserCurrentLocationCity = reversedGeoLocation.city
                    }
                    
                    let marker = GMSMarker()
                    let markerView = UIImageView(image: UIImage(named: "marker_green"))
                    marker.position = CLLocationCoordinate2D(latitude: CurrentLatitudeValue, longitude: CurrentLongitudeValue)
                    marker.iconView = markerView
                    marker.map = self.mapView
                    
                    let camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: CurrentLatitudeValue, longitude: CurrentLongitudeValue), zoom: 12)
                   self.mapView.animate(to: camera)
                    
                    self.getNextRideTime()
                } else {
                    print("Get Location failed \(self.getLocation.didFailWithError)")
                }
            }
        }
    }
}
extension DashBoardViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
    
    
}
// MARK: - CLLocationManagerDelegate
extension DashBoardViewController: CLLocationManagerDelegate {
    
    //MARK: - NextRIDETime
    func getNextRideTime() {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        str_DerviceToken = UserDefaults.standard.string(forKey: "FCMDeviceToken") ?? ""

        indicator.showActivityIndicator()
        let perams = [ "driver_id":DriverLoginID,
                       "latitude":self.str_UserCurrentLocationLatitude,
                       "longitude":self.str_UserCurrentLocationLongitude,
                       "devicetoken":self.str_DerviceToken,
                       "type":"driver",
                       "device_type":"ios",
                       "app_version":str_Version,
                       "Online_status": "1"
        ]
        self.viewModel.requestForNextRIDETimeAPIServices(perams: perams) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    // next ride
                    if let nextRideTime = UserData.time_left, nextRideTime != "" {
                        self.lbl_FutureRideItimationRef.text = nextRideTime
                        NextRideTimeShowViewref.isHidden = false
                        NextRideTimeShowHeightref.constant = 50
                    }
                    // google key
                    if let googleKey = UserData.google_key, googleKey != ""{
                        UserDefaults.standard.set(googleKey, forKey: "Googlekeyvalue")
                    }
                    self.getgooglekeyListAPI()
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                    self.getgooglekeyListAPI()
                }
            }
            
        }
        
    }
}

extension DashBoardViewController {
    //MARK: - DriverOnlineAPI
    func driverOnlineAPI() {
//        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
//        indicator.showActivityIndicator()
//
//        self.viewModel2.requestForDriverOnlineAPIServices(perams: ["driverid":DriverLoginID,"status":"1","app_version" : str_Version,"version":"yes"]) { success, model, error in
//            if success, let userData = model {
//                DispatchQueue.main.async { [self] in
//                    indicator.hideActivityIndicator()
//                    if userData.status == "1" {
//                     print("success")
//                    } else if userData.status == "4" {
//                        self.ShowAlert(message: model?.message ?? "")
//                    }
//                }
//            } else if let userData = model {
//                DispatchQueue.main.async { [self] in
//                    indicator.hideActivityIndicator()
//                     self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
//                 }
//             }
//        }
    }
}
extension DashBoardViewController {
    //MARK: - DriverUpdateCurrentLocationAPI
    func driverUpdateCurrentLocationAPI() {
        //rideid=%@&driverid
//        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
//        indicator.showActivityIndicator()
//
//        self.viewModel3.requestForDriverUpdateCurrentLocationAPIServices(perams: ["driverid":DriverLoginID,"latitude":self.str_UserCurrentLocationLatitude,"longitude":self.str_UserCurrentLocationLongitude,"app_version" : str_Version]) { success, model, error in
//            if success, let userData = model {
//                DispatchQueue.main.async { [self] in
//                    indicator.hideActivityIndicator()
//                     print("Success")
//                }
//            } else {
//                DispatchQueue.main.async { [self] in
//                    indicator.hideActivityIndicator()
//                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
//                }
//             }
//        }

    }
}

//extension DashBoardViewController {
//      func getOperation1() -> Operation {
//        let operation: Operation = BlockOperation { () -> Void in
//            self.driverUpdateCurrentLocationAPI()
//        }
//         return operation
//    }
//
//    func getOperation2() -> Operation {
//        let operation: Operation = BlockOperation { () -> Void in
//            self.driverOnlineAPI()
//        }
//         return operation
//    }
//
//    func getOperation3() -> Operation {
//        let operation: Operation = BlockOperation { () -> Void in
//            self.getNextRideTime()
//        }
//         return operation
//    }
//}

extension DashBoardViewController {
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
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "no record found.", font: .systemFont(ofSize: 12.0))
                }
            }
        }
    }
}
extension DashBoardViewController {
    //MARK: - driverCurrentRideDetailsAPI
//    func driverCurrentRideDetailsAPI() {
//        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
//        indicator.showActivityIndicator()
//        self.viewModel4.requestForDriverCurrentRideDetailsAPIServices(perams: ["driver_id":DriverLoginID,"devicetoken":str_DerviceToken,"device_type": "ios","type":"DRIVER","app_version":str_Version]) { success, model, error in
//            if success, let userData = model {
//                DispatchQueue.main.async { [self] in
//                    indicator.hideActivityIndicator()
//                    print("success")
//                }
//            }else {
//                DispatchQueue.main.async { [self] in
//                    indicator.hideActivityIndicator()
//                print("failure")
//                }
//            }
//        }
//    }
}
