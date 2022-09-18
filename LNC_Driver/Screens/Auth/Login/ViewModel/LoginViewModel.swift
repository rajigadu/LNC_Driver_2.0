//
//  LoginViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 13/09/22.
//

import Foundation

class LoginViewModel: NSObject {
    
    private var LoginedServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.LoginedServices = ApiService
    }
    
    func getUserDetails(perams: Dictionary<String,String>, completion: @escaping (Bool, UserData?, String?) -> ()) {
        LoginedServices.getLoginedUserDetails(perams) { success, model, error in
            if success, let LoginedUser = model {
                if LoginedUser.loginStatus == "1" {
                    UserDefaults.standard.set(LoginedUser.userDetails?[0].userId, forKey: "DriverLoginID")
                    UserDefaults.standard.set(LoginedUser.userDetails?[0].email, forKey: "DriverEmailID")
                    UserDefaults.standard.set(LoginedUser.userDetails?[0].first_name, forKey: "DriverFirstName")
                    UserDefaults.standard.set(LoginedUser.userDetails?[0].last_name, forKey: "DriverLasttName")
                    UserDefaults.standard.set(LoginedUser.userDetails?[0].mobile, forKey: "DriverMobilenumber")
                    UserDefaults.standard.set(LoginedUser.userDetails?[0].rating, forKey: "DriverRating")
                    UserDefaults.standard.set(true, forKey: "IsUserLogined")
                    UserDefaults.standard.set(API_URl.API_IMAGEBASE_URL + (LoginedUser.userDetails?[0].profile_pic ?? ""), forKey: "DriverProfilepic")
                    UserDefaults.standard.set(LoginedUser.userDetails?[0].driver_type, forKey: "DriverType")
                    UserDefaults.standard.set("Driver", forKey: "InRideDriverType")
                    completion(true, LoginedUser, nil)
                } else {
                    completion(false, nil, LoginedUser.message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
