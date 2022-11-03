//
//  ForgotPasswordViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 13/09/22.
//

import Foundation

class ForgotPasswordViewModel: NSObject {
    
    private var ForgotPasswordServices: LateNightChauffeursDriverServiceProtocol
        
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.ForgotPasswordServices = ApiService
    }
    
    func requestForForgotPasswordServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ForgotPasswordUserData?, String?) -> ()) {
        ForgotPasswordServices.requestForForgotPasswordServices(perams) { success, model, error in
            if success, let ForgotPasswordUserData = model {
                completion(true, ForgotPasswordUserData, nil)
             } else {
                completion(false, nil, error)
            }
        }
    }
}
