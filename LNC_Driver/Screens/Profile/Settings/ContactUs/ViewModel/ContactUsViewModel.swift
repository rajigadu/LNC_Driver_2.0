//
//  ContactUsViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 15/09/22.
//

import Foundation

class ContactUsViewModel: NSObject {
    
    private var ContactUsServices: LateNightChauffeursDriverServiceProtocol
        
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.ContactUsServices = ApiService
    }
    
    func requestForContactUsServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ContactUsUserData?, String?) -> ()) {
        ContactUsServices.requestForContactUsServices(perams) { success, model, error in
            if success, let ContactUsUserData = model {
                completion(true, ContactUsUserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
