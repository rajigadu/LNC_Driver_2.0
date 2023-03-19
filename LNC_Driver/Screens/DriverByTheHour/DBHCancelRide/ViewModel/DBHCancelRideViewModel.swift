//
//  DBHCancelRideViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 19/03/23.
//

import Foundation
import UIKit

class DBHCancelRideViewModel: NSObject {
    
    private var dbhCancelRideServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.dbhCancelRideServices = ApiService
    }
    
    //MARK: - DriverFutureCancelRideAPI
    func requestForDriverDBHRideCancelAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, CancelRideData?, String?) -> ()) {
        dbhCancelRideServices.requestForDriverDBHRideCancelAPIServices(perams){ success, model, error in
            if success, let userData = model {
                completion(true, userData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
