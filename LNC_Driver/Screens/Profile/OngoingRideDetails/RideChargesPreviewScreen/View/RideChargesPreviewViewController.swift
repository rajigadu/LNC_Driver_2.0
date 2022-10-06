//
//  RideChargesPreviewViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 02/10/22.
//

import UIKit

class RideChargesPreviewViewController: UIViewController {

    @IBOutlet weak var lbl_RideCostRef: UILabel!
    @IBOutlet weak var lbl_EarningsRef: UILabel!
    @IBOutlet weak var lbl_TotalRideCostRef: UILabel!
    @IBOutlet weak var AdminFeelblref: UILabel!
    @IBOutlet weak var Unpanedstopslbl_ref: UILabel!
    @IBOutlet weak var Waitingtimelblref: UILabel!
    
    var str_RideUserID = ""
    var str_CurrentRideID = ""
    var str_RideCost = ""
    var str_WaitingCharges = ""
    var str_TotalRideCost = ""
    var str_ComingFrom = ""
    var str_UserName = ""
    var str_UserimageUrl = ""
    var str_waitingtime = ""
    var str_Additionalstops = ""
    var str_Ridefare = ""
    var str_earnings = ""
    var Str_AdminFare = ""
    var loginDriverID = ""
    
    lazy var viewModel = {
        RideChargesPreviewViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ride Preview"
        loginDriverID = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        
        if str_Additionalstops.count ?? 0 > 0 {
            Unpanedstopslbl_ref.text = "Unplanned Stops  : 0"
        } else {
            Unpanedstopslbl_ref.text = "Unplanned Stops  : \(str_Additionalstops ?? "")"
        }
        
        if str_waitingtime.count ?? 0 > 0 {
            Waitingtimelblref.text = "Waiting Time : 00:00"
        } else {
            Waitingtimelblref.text = "Waiting Time : \(str_waitingtime) Minutes"
        }
        self.lbl_TotalRideCostRef.text = "Ride Fare : $" + str_Ridefare
        self.lbl_EarningsRef.text = "Earnings : $" + str_earnings
        self.AdminFeelblref.text = "Admin Fee : $" + Str_AdminFare
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_CompleteRideActionRef(_ sender: Any) {
        if self.str_ComingFrom == "Future Ride" {
            self.driverFutureRideCompleteAPI(withDriverID : loginDriverID,
                                              withUserID : self.str_RideUserID,
                                              withRideID : self.str_CurrentRideID,
                                     withAdditionalStops :  self.str_Additionalstops,
                                         withWaitingTime : self.str_waitingtime)
        } else {
            self.driverCurrentRideCompleteAPI(withDriverID : loginDriverID,
                                   withUserID : self.str_RideUserID,
                                   withRideID : self.str_CurrentRideID)
        }
    }

}

extension RideChargesPreviewViewController {
    //MARK: - DriverCurrentRideCompleteAPI
    func driverCurrentRideCompleteAPI(withDriverID : String,
    withUserID : String,withRideID : String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverCurrentRideCompleteAPIServices(perams: ["driverid":DriverLoginID,"userid":withUserID,"ride_id": withRideID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()

                    UserDefaults.standard.removeObject(forKey: "PartnerMobileNumberForDriver")
                    UserDefaults.standard.set(nil, forKey: "PartnerMobileNumberForDriver")
                    
                    UserDefaults.standard.removeObject(forKey: "PartnerIDForDriver")
                    UserDefaults.standard.set(nil, forKey: "PartnerIDForDriver")

                    UserDefaults.standard.removeObject(forKey: "PartnerDetailsFromServer")
                    UserDefaults.standard.set(nil, forKey: "PartnerDetailsFromServer")

                    UserDefaults.standard.removeObject(forKey: "DriverServiceType")
                    UserDefaults.standard.set(nil, forKey: "DriverServiceType")

                    self.driverCurrentRidePaymentAPI(withUserID: self.str_RideUserID, withRideID: self.str_CurrentRideID)
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                }
             }
        }
    }
}

extension RideChargesPreviewViewController {
    //MARK: - DriverCurrentRidePaymentAPI
    func driverCurrentRidePaymentAPI(withUserID: String, withRideID: String) {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverCurrentRidePaymentAPIServices(perams: ["user_id":withUserID,"booking_id":withRideID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    let alertController = UIAlertController(title: kApptitle, message: userData.message ?? "", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                        let Storyboard : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
                        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
                        nxtVC.str_UserID = self.str_RideUserID;
                        nxtVC.str_Username = self.str_UserName;
                        nxtVC.str_UserImageUrl = self.str_UserimageUrl;
                        self.navigationController?.pushViewController(nxtVC, animated: true)
                    }
                    
                    let CancellAction = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
                    }
                    alertController.addAction(OKAction)
                    alertController.addAction(CancellAction)
                    self.present(alertController, animated: true, completion: nil)

                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                }
             }
        }
    }
}

extension RideChargesPreviewViewController {
    //MARK: - DriverFutureRidePaymentAPI
    func driverFutureRidePaymentAPI(withUserID: String, withRideID: String) {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        let currDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"
        let todayDate = dateFormatter.string(from: currDate)
        
        self.viewModel.requestForDriverFutureRidePaymentAPIServices(perams: ["user_id":withUserID,"booking_id":withRideID,"PayDateTime": todayDate]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    let alertController = UIAlertController(title: kApptitle, message: userData.message ?? "", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                        let Storyboard : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
                        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
                        nxtVC.str_UserID = self.str_RideUserID;
                        nxtVC.str_Username = self.str_UserName;
                        nxtVC.str_UserImageUrl = self.str_UserimageUrl;
                        self.navigationController?.pushViewController(nxtVC, animated: true)
                    }
                    
                    let CancellAction = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
                    }
                    alertController.addAction(OKAction)
                    alertController.addAction(CancellAction)
                    self.present(alertController, animated: true, completion: nil)

                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                }
             }
        }
    }
}
extension RideChargesPreviewViewController {
    //MARK: - DriverFutureRideCompleteAPI
    func driverFutureRideCompleteAPI(withDriverID : String,
                                     withUserID : String, withRideID : String, withAdditionalStops:String, withWaitingTime: String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverFutureRideCompleteAPIServices(perams: ["driverid":DriverLoginID
                                                                              ,"userid":withUserID,"ride_id": withRideID,"unplanned_stops":withAdditionalStops,"waiting_time":withWaitingTime]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.driverFutureRidePaymentAPI(withUserID: self.str_RideUserID, withRideID: self.str_CurrentRideID)
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                }
             }
        }
    }
}
