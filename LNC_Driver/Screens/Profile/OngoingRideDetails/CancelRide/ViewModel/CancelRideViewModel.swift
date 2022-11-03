//
//  CancelRideViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 02/10/22.
//

import Foundation
import UIKit

class CancelRideViewModel: NSObject {
    
    private var cancelRideServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.cancelRideServices = ApiService
    }
    
    //MARK: - DriverFutureCancelRideAPI
    func requestForDriverFutureCancelRideAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, CancelRideData?, String?) -> ()) {
        cancelRideServices.requestForDriverFutureCancelRideAPIServices(perams){ success, model, error in
            if success, let userData = model {
                completion(true, userData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - PartnerFutureCancelRideAPI
    func requestForPartnerFutureCancelRideAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, CancelRideData?, String?) -> ()) {
        cancelRideServices.requestForPartnerFutureCancelRideAPIServices(perams){ success, model, error in
            if success, let userData = model {
                completion(true, userData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - DriverOnlineAPI
    func requestForDriverOnlineAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, CancelRideData?, String?) -> ()) {
        cancelRideServices.requestForDriverOnlineAPIServices(perams){ success, model, error in
            if success, let userData = model {
                completion(true, userData, nil)
              } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - DriverCurrentCancelRideAPI
    func requestForDriverCurrentCancelRideAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, CancelRideData?, String?) -> ()) {
        cancelRideServices.requestForDriverCurrentCancelRideAPIServices(perams){ success, model, error in
            if success, let userData = model {
                completion(true, userData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - PartnerCurrentCancelRideAPI
    func requestForPartnerCurrentCancelRideAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, CancelRideData?, String?) -> ()) {
        cancelRideServices.requestForPartnerCurrentCancelRideAPIServices(perams){ success, model, error in
            if success, let userData = model {
                completion(true, userData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
