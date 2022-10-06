//
//  ChangePasswordViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 15/09/22.
//

import Foundation

class ChangePasswordViewModel: NSObject {
    
    private var ChangePasswordServices: LateNightChauffeursDriverServiceProtocol
        
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.ChangePasswordServices = ApiService
    }
    
    func requestForChangePasswordServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ChangePasswordUserData?, String?) -> ()) {
        ChangePasswordServices.requestForChangePasswordServices(perams) { success, model, error in
            if success, let ChangePasswordUserData = model {
                if ChangePasswordUserData.loginStatus == "1" {
                    completion(true, ChangePasswordUserData, nil)
                } else {
                    completion(false, nil, ChangePasswordUserData.userData?[0].Message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}

