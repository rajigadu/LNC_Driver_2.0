//
//  ChangePasswordViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 15/09/22.
//

import Foundation
import UIKit

class ChangePasswordViewController: UIViewController {

    //MARK: - Class outlets
    @IBOutlet weak var txt_OldpasswordRef: UITextField!
    @IBOutlet weak var txt_NewpasswordRef: UITextField!
    @IBOutlet weak var txt_ConfirmpasswordRef: UITextField!
    @IBOutlet weak var btn_UpdatepasswordRef: UIButton!
    
    //MARK: - Class Propeties
    lazy var viewModel = {
        ChangePasswordViewModel()
    }()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Change password"
        // Do any additional setup after loading the view.
    }

    //MARK: - Class Actions
    @IBAction func submitChangePassword(_ sender: Any) {
        ChangePasswordApiCall()
    }
}

extension ChangePasswordViewController {
    
    //MARK: - Api Intigration
    func ChangePasswordApiCall(){
        guard let str_Oldpassword = txt_OldpasswordRef.text else {return}
        guard let str_Newpassword = txt_NewpasswordRef.text else {return}
        guard let str_Confirmpassword = txt_ConfirmpasswordRef.text else {return}
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}

        if str_Oldpassword.isEmpty || str_Newpassword != str_Confirmpassword || str_Newpassword.isEmpty || str_Confirmpassword.isEmpty || str_userID.isEmpty {
            self.ShowAlert(message: "Please Eneter Valid Credentials!")
        } else {
            indicator.showActivityIndicator()
            self.viewModel.requestForChangePasswordServices(perams: ["driverid":str_userID,"oldpassword":str_Oldpassword,"newpassword":str_Newpassword]) { success, model, error in
                if success, let ChangePasswordUserData = model {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        if ChangePasswordUserData.loginStatus == "1" {
                            self.ShowAlertWithPop(message: ChangePasswordUserData.userData?[0].Message ?? "Your Password has been updated successfully.")
                        } else {
                            self.showToast(message: ChangePasswordUserData.userData?[0].Message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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

}
