//
//  DBHRidePreviewViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 16/03/23.
//

import UIKit

class DBHRidePreviewViewController: UIViewController {

    @IBOutlet weak var CustomerImage: UIImageView!
    @IBOutlet weak var CustomernameLabel: UILabel!
    @IBOutlet weak var CustomerNumberLabel: UILabel!
    @IBOutlet weak var PickUpAddressLabel: UILabel!
    @IBOutlet weak var RideBookingDateLabel: UILabel!
    @IBOutlet weak var RideStatusLabel: UILabel!
    @IBOutlet weak var StartRideButton: UIButton!
    
    var assignRideDetails: ListOfAssignRidesDataR?
    
    var viewModel = {
        return DBHRidePreviewViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadUI()
    }
    
    func loadUI() {
        self.CustomernameLabel.text = assignRideDetails?.first_name ?? "" + (assignRideDetails?.last_name ?? "")
        self.CustomerNumberLabel.text = assignRideDetails?.mobile ?? ""
        self.PickUpAddressLabel.text = "Pickup: " + (assignRideDetails?.pickup_address ?? "")
        self.RideBookingDateLabel.text = "Pickup Date/Time: " + (assignRideDetails?.otherdate ?? "") + " " + (assignRideDetails?.time ?? "")
        //self.RideStatusLabel.isHidden = true
        self.RideStatusLabel.isHidden = self.StartRideButton.currentTitle == "COMPLETE RIDE" ? false : true
    }

    @IBAction func CallToUserButton(_ sender: Any) {
        guard let  userNumber = assignRideDetails?.mobile else {
            self.ShowAlert(message:"Currently driver have No Number")
            return
        }
        let application = UIApplication.shared
        if let anURL = URL(string: "\("tel://" + userNumber)"){
            application.open(anURL, options: [:]) { success in
                if success {
                }
            }
        }
    }
    
    
    @IBAction func ChatWithUserButton(_ sender: Any) {
        guard let  userID = assignRideDetails?.user_id else {
            return
        }
        UserDefaults.standard.set("Coming From Future Ride", forKey: "ChatFromLaunchScreen")
        let Storyboard : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        nxtVC.str_ChatStatus = ""
        nxtVC.str_CurrentRideDriverID = userID
        nxtVC.str_ChatType = "ToUser"
        nxtVC.vcCmgFrom  = "AppDelegate"
        self.navigationController?.pushViewController(nxtVC, animated: true)
    }
    
    @IBAction func GoToUserLocationButton(_ sender: Any) {
        guard let pickup_lat = assignRideDetails?.pickup_lat else {
            return
        }
        
        guard let pickup_long = assignRideDetails?.pickup_long else {
            return
        }
        
        let googleMapUrlString = "http://maps.google.com/?saddr=\(CurrentLatitude),\(CurrentLongitude)&daddr=\(pickup_lat),\(pickup_long)"
        
        let application = UIApplication.shared
        if let anURL = URL(string: googleMapUrlString) {
            application.open(anURL, options: [:]) { success in
                if success {
                    print("Opened url")
                }
            }
        }
    }
    
    @IBAction func StartRideButton(_ sender: Any) {
        if self.StartRideButton.currentTitle == "COMPLETE RIDE" {
            let alertController = UIAlertController(title: kApptitle, message: I18n.completeRide, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                self.endRideApiService()
            }
            let CancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            }
            alertController.addAction(OKAction)
            alertController.addAction(CancelAction)
            self.present(alertController, animated: true, completion: nil)
        } else if self.StartRideButton.currentTitle == "START RIDE" {
            self.startRideApiService()
        }
    }
    
    @IBAction func CancelRideButton(_ sender: Any) {
        guard let rideID = assignRideDetails?.id as? String else {return}
        let alertController = UIAlertController(title: kApptitle, message: "Are you sure you want to cancel this ride?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            let Storyboard : UIStoryboard = UIStoryboard(name: "DriverByTheHour", bundle: nil)
            let nxtVC = Storyboard.instantiateViewController(withIdentifier: "DBHCancelRideViewController") as! DBHCancelRideViewController
            nxtVC.str_CurrentRideID = rideID
            self.navigationController?.pushViewController(nxtVC, animated: true)
        }
        
        let CancellAction = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
        }
        alertController.addAction(OKAction)
        alertController.addAction(CancellAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func refreshApiButton(_ sender: Any) {
    }
    
    
    func convertTodaydateformate(inputDate: Date, outputDateFormate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outputDateFormate // output date format
        let dateString = dateFormatter.string(from: inputDate)
        print(dateString) // "Mar 19, 2022"
        return dateString
    }
    
}
extension DBHRidePreviewViewController {
    func startRideApiService() {
        guard let rideID = assignRideDetails?.id as? String else {return}
        guard let driverID = UserDefaults.standard.string(forKey: "DriverLoginID") as? String else {return}
        indicator.showActivityIndicator()
        let startTIme : String = convertTodaydateformate(inputDate: Date(), outputDateFormate: "yyyy-MM-dd hh:mm a")
        let perams = ["rideid": rideID, "driverid": driverID,"time": startTIme]
        self.viewModel.DbhRideStartApiIntigration(perams: perams) { Success, userModel, error in
            if Success, let userdata = userModel {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.ShowAlert(message: userdata.msg ?? "Your ride has been started" )
                    self.StartRideButton.setTitle("COMPLETE RIDE", for: .normal)
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.ShowAlert(message: error ?? I18n.SomethingWentWrong )
                }
            }
        }
    }
}

extension DBHRidePreviewViewController {
    func endRideApiService() {
        guard let rideID = assignRideDetails?.id as? String else {return}
        guard let firstName = assignRideDetails?.first_name as? String else {return}
        guard let lastName = assignRideDetails?.last_name as? String else {return}
        guard let driverID = UserDefaults.standard.string(forKey: "DriverLoginID") as? String else {return}
        indicator.showActivityIndicator()
        let startTIme : String = convertTodaydateformate(inputDate: Date(), outputDateFormate: "yyyy-MM-dd hh:mm a")
        let perams = ["rideid": rideID, "driverid": driverID,"time": startTIme]
        self.viewModel.DbhRideEndApiIntigration(perams: perams) { Success, userModel, error in
            if Success, let userdata = userModel {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    let alertController = UIAlertController(title: kApptitle, message: userData.msg ?? "", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                        let Storyboard : UIStoryboard = UIStoryboard(name: "DriverByTheHour", bundle: nil)
                        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "DBHFeedbackViewController") as! DBHFeedbackViewController
                        nxtVC.str_UserID = rideID
                        nxtVC.str_Username = firstName + " " + lastName
                     
                        self.navigationController?.pushViewController(nxtVC, animated: true)
                    }
                    alertController.addAction(OKAction)
                     self.present(alertController, animated: true, completion: nil)

                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.ShowAlert(message: error ?? I18n.SomethingWentWrong )
                }
            }
        }
    }
}
