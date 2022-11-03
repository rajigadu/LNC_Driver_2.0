//
//  NotificationViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 06/10/22.
//

import Foundation

class NotificationViewModel: NSObject {
    
    private var NotificationServices: LateNightChauffeursDriverServiceProtocol
        
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.NotificationServices = ApiService
    }
    
    func requestForNotificationAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, NotificationData?, String?) -> ()) {
        NotificationServices.requestForNotificationServices(perams) { success, model, error in
            if success, let UserData = model {
                    completion(true, UserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
}


