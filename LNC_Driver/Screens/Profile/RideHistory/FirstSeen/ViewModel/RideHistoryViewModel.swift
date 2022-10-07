//
//  RideHistoryViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import Foundation
import UIKit

class RideHistoryViewModel: NSObject {
    
    private var rideHistoryServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.rideHistoryServices = ApiService
    }
    
    func requestForRideHistoryServices(perams: Dictionary<String,String>, completion: @escaping (Bool, RideHistoryViewData?, String?) -> ()) {
        rideHistoryServices.requestForRideHistoryServices(perams){ success, model, error in
            if success, let EditProfileUserData = model {
                if EditProfileUserData.status == "1" {
                    completion(true, EditProfileUserData, nil)
                } else {
                    completion(false, nil, I18n.SomethingWentWrong)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
