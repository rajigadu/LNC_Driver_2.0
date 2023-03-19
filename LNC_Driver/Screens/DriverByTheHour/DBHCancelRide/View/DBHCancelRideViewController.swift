//
//  DBHCancelRideViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 19/03/23.
//

import UIKit

class DBHCancelRideViewController: UIViewController {

    
    @IBOutlet weak var textview_DescriptionRef: UITextView!
    @IBOutlet weak var lbl_messageRef: UILabel!
    
    var str_CurrentRideID = ""
    
    lazy var viewModel = {
        DBHCancelRideViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cancel Ride"
    }
    
    @IBAction func btn_CancelActionRef(_ sender: Any) {
        self.popToBackVC()
    }
    
    @IBAction func btn_SubmitActionRef(_ sender: Any) {
            self.driverCancelDBHRideAPI(withReason : self.textview_DescriptionRef.text,
                                            withRideID : self.str_CurrentRideID)

    }
}

extension DBHCancelRideViewController {
    //MARK: - DriverFutureCancelRideAPI
    func driverCancelDBHRideAPI(withReason : String,
                                   withRideID : String){
        
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverDBHRideCancelAPIServices(perams: ["driver_id":DriverLoginID,"ride_id":withRideID,"reason": withReason]) { success, model, error in
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
