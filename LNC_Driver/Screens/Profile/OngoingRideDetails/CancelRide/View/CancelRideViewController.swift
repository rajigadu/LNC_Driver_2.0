//
//  CancelRideViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 02/10/22.
//

import UIKit

class CancelRideViewController: UIViewController {
    
    @IBOutlet weak var textview_DescriptionRef: UITextView!
    @IBOutlet weak var lbl_messageRef: UILabel!
    
    var str_CurrentRideID = ""
    var str_ComingFrom = ""
    var str_PartnerID = ""
    
    var str_DriverLoginID = ""
    
    lazy var viewModel = {
        CancelRideViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.lbl_messageRef.isHidden = true
        self.title = "Cancel Ride"
        str_DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_CancelActionRef(_ sender: Any) {
        self.popToBackVC()
    }
    
    @IBAction func btn_SubmitActionRef(_ sender: Any) {
        if self.str_ComingFrom == "PartnerFutureRide" {
            self.partnerFutureCancelRideAPI(BasedDriverID : str_DriverLoginID,
                                            withReason : self.textview_DescriptionRef.text,
                                            withRideID : self.str_CurrentRideID)
        } else if str_ComingFrom == "PartnerCurrentRide" {
            self.partnerCurrentCancelRideAPI(BasedDriverID : str_DriverLoginID,
                                             withReason : self.textview_DescriptionRef.text,
                                             withRideID : self.str_CurrentRideID)
            
        } else if str_ComingFrom == "FutureRide" {
            self.driverFutureCancelRideAPI(BasedDriverID : str_DriverLoginID,
                                           withReason : self.textview_DescriptionRef.text,
                                           withRideID : self.str_CurrentRideID,
                                           withPartnerID : str_PartnerID)
        } else {
            self.driverCurrentCancelRideAPI(BasedDriverID : str_DriverLoginID,
                                            withReason : self.textview_DescriptionRef.text,
                                            withRideID : self.str_CurrentRideID)
            
        }
    }
}

extension CancelRideViewController {
    //MARK: - DriverFutureCancelRideAPI
    func driverFutureCancelRideAPI(BasedDriverID : String,
                                   withReason : String,
                                   withRideID : String,
                                   withPartnerID : String){
        
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverFutureCancelRideAPIServices(perams: ["driver_id":DriverLoginID,"ride_id":withRideID,"reason": withReason,"partner_id":withPartnerID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                        self.ShowAlertWithPush(message: userData.message ?? "Successfully Done" , className: "DashBoardViewController", storyBoard: "DashBoard", Animation: true)
                    } else {
                        self.showToast(message: error ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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

extension CancelRideViewController {
    //MARK: - PartnerFutureCancelRideAPI
    func partnerFutureCancelRideAPI(BasedDriverID: String, withReason: String, withRideID: String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForPartnerFutureCancelRideAPIServices(perams: ["driver_id":DriverLoginID,"ride_id":withRideID,"reason": withReason]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                        self.ShowAlertWithPush(message: userData.message ?? "Successfully Done" , className: "DashBoardViewController", storyBoard: "DashBoard", Animation: true)
                    } else {
                        self.showToast(message: error ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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

extension CancelRideViewController {
    //MARK: - DriverOnlineAPI
    func driverOnlineAPI(withDriverID: String, withOnOfflineStatus: String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverOnlineAPIServices(perams: ["driverid":DriverLoginID,"status":withOnOfflineStatus]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                        print("success")
                    } else if userData.status == "4" {
                        self.ShowAlert(message: model?.message ?? "")
                    } else {
                        self.showToast(message: error ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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

extension CancelRideViewController {
    //MARK: - DriverCurrentCancelRideAPI
    func driverCurrentCancelRideAPI(BasedDriverID: String, withReason: String, withRideID: String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverCurrentCancelRideAPIServices(perams: ["driver_id":DriverLoginID,"ride_id":withRideID,"reason": withReason]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                        let alertController = UIAlertController(title: kApptitle, message: userData.message ?? "", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                            self.driverOnlineAPI(withDriverID : self.str_DriverLoginID, withOnOfflineStatus : "1")
                        }
                        alertController.addAction(OKAction)
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        self.showToast(message: error ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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

extension CancelRideViewController {
    //MARK: - PartnerCurrentCancelRideAPI
    func partnerCurrentCancelRideAPI(BasedDriverID: String, withReason: String, withRideID: String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForPartnerCurrentCancelRideAPIServices(perams: ["driver_id":DriverLoginID,"ride_id":withRideID,"reason": withReason]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                        let alertController = UIAlertController(title: kApptitle, message: "Current ride canceled successfully", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                            self.driverOnlineAPI(withDriverID : self.str_DriverLoginID, withOnOfflineStatus : "1")
                        }
                        alertController.addAction(OKAction)
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        self.showToast(message: error ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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
