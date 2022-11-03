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
                    completion(true, LoginedUser, nil)
                } else {
                    completion(false, nil, error)
                }
            }
        }
    }
}
