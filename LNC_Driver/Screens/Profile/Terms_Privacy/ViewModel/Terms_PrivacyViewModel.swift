//
//  Terms_PrivacyViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import Foundation

class Terms_PrivacyViewModel: NSObject {
    
    private var Terms_PrivacyServices: LateNightChauffeursDriverServiceProtocol
        
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.Terms_PrivacyServices = ApiService
    }
    
    func requestForGetEmplyeeGuideLinesPDFServices(perams: Dictionary<String,String>, completion: @escaping (Bool, TermsPrivacyData?, String?) -> ()) {
        Terms_PrivacyServices.requestForGetEmplyeeGuidelinesServices(perams) { success, model, error in
            if success, let UserData = model {
                if UserData.loginStatus == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
