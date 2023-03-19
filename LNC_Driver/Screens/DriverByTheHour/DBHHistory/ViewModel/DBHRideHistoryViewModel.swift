//
//  DBHRideHistoryViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 19/03/23.
//

import Foundation
import UIKit

class DBHRideHistoryViewModel: NSObject {
    
    private var dbhRideHistoryServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.dbhRideHistoryServices = ApiService
    }
    
    func requestForDBHRideHistoryServices(perams: Dictionary<String,String>, completion: @escaping (Bool, DBHRideHistoryData?, String?) -> ()) {
        dbhRideHistoryServices.requestForDBHRideHistoryServices(perams){ success, model, error in
            if success, let RideHistoryUserData = model {
                completion(true, RideHistoryUserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}

