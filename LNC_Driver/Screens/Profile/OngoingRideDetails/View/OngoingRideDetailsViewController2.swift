//
//  OngoingRideDetailsViewController2.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 01/10/22.
//

import Foundation
import UIKit
import CoreLocation

import CoreLocation

public class GetLocation: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var locationCallback: ((CLLocation?) -> Void)!
    var locationServicesEnabled = false
    var didFailWithError: Error?

    public func run(callback: @escaping (CLLocation?) -> Void) {
        locationCallback = callback
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestWhenInUseAuthorization()
        locationServicesEnabled = CLLocationManager.locationServicesEnabled()
        if locationServicesEnabled { manager.startUpdatingLocation() }
        else { locationCallback(nil) }
    }

   public func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        locationCallback(locations.last!)
        manager.stopUpdatingLocation()
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFailWithError = error
        locationCallback(nil)
        manager.stopUpdatingLocation()
    }
    


    deinit {
        manager.stopUpdatingLocation()
    }
    
    
}
extension UIViewController {
    func askEnableLocationService() ->String {
        var showAlertSetting = false
        var showInitLocation = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .denied:
                showAlertSetting = true
                print("HH: kCLAuthorizationStatusDenied")
            case .restricted:
                showAlertSetting = true
                print("HH: kCLAuthorizationStatusRestricted")
            case .authorizedAlways:
                showInitLocation = true
                print("HH: kCLAuthorizationStatusAuthorizedAlways")
            case .authorizedWhenInUse:
                showInitLocation = true
                print("HH: kCLAuthorizationStatusAuthorizedWhenInUse")
            case .notDetermined:
                showInitLocation = true
                print("HH: kCLAuthorizationStatusNotDetermined")
            default:
                break
            }
        }else{
            showAlertSetting = true
            print("HH: locationServicesDisabled")

        }
        if showAlertSetting {
            let alertController = UIAlertController(title: kApptitle, message: "To re-enable, please go to Settings and turn on Location Service for this app.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }

            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
        if showInitLocation {

            return "YES"

        }
        return "NO"

    }
}
