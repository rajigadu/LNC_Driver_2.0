//
//  LoginViewController.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - IBOutLets
    @IBOutlet weak var txt_PasswordRef: UITextField!
    @IBOutlet weak var txt_UserMailRef: UITextField!
    @IBOutlet weak var btn_LoginRef: UIButton!
    
    //MARK: - Properties
    lazy var viewModel = {
        LoginViewModel()
    }()
    
    //MARK: - Life Cycle Start
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - UI-Button Actions
    
    @IBAction func signINButton(_ sender: Any) {
        self.loginApiCall()
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        self.movetonextvc(id: "ForgotPasswordViewController", storyBordid: "Authentication", animated: true)
    }
    
    @IBAction func signUPButton(_ sender: Any) {
        self.movetonextvc(id: "RegistrationViewController", storyBordid: "Authentication", animated: true)
    }
    
}
extension LoginViewController {
    //Api Intigration
    func loginApiCall(){
        guard let userEmail = txt_UserMailRef.text else {return}
        guard let userPassword = txt_PasswordRef.text else {return}
        if userEmail.isEmpty || !isValidEmail(userEmail) || userPassword.isEmpty {
            self.ShowAlert(message: "Please Eneter Valid Credentials!")
        } else {
            indicator.showActivityIndicator()
            self.viewModel.getUserDetails(perams: ["emailid":userEmail,"password":userPassword]) { success, model, error in
                if success, let LoginedUser = model {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        if LoginedUser.loginStatus == "1" {
                            UserDefaults.standard.set(LoginedUser.userDetails?[0].userId,         forKey: "DriverLoginID")
                            UserDefaults.standard.set(LoginedUser.userDetails?[0].email, forKey: "DriverEmailID")
                            UserDefaults.standard.set(LoginedUser.userDetails?[0].first_name, forKey: "DriverFirstName")
                            UserDefaults.standard.set(LoginedUser.userDetails?[0].last_name, forKey: "DriverLasttName")
                            UserDefaults.standard.set(LoginedUser.userDetails?[0].mobile, forKey: "DriverMobilenumber")
                            UserDefaults.standard.set(LoginedUser.userDetails?[0].rating, forKey: "DriverRating")
                            UserDefaults.standard.set(true, forKey: "IsUserLogined")
                            UserDefaults.standard.set(API_URl.API_IMAGEBASE_URL + (LoginedUser.userDetails?[0].profile_pic ?? ""), forKey: "DriverProfilepic")
                            UserDefaults.standard.set(LoginedUser.userDetails?[0].driver_type, forKey: "DriverType")
                            UserDefaults.standard.set("Driver", forKey: "InRideDriverType")
                            
                            self.movetonextvc(id: "DriverTypeViewController", storyBordid: "RidesHistory",animated:false)
                        } else {
                            self.showToast(message: LoginedUser.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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
