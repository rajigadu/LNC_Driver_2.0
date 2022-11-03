//
//  RideChargesPreviewViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 02/10/22.
//

import Foundation
import UIKit

class RideChargesPreviewViewModel: NSObject {
    
    private var RideChargesPreviewServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.RideChargesPreviewServices = ApiService
    }
    
    //MARK: - DriverCurrentRideCompleteAPI
    func requestForDriverCurrentRideCompleteAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, RideChargesPreviewData?, String?) -> ()) {
        RideChargesPreviewServices.requestForDriverCurrentRideCompleteAPIServices(perams){ success, model, error in
            if success, let DriverCurrentRideComplete = model {
                completion(true, DriverCurrentRideComplete, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - DriverCurrentRidePaymentAPI
    func requestForDriverCurrentRidePaymentAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, RideChargesPreviewData?, String?) -> ()) {
        RideChargesPreviewServices.requestForDriverCurrentRidePaymentAPIServices(perams){ success, model, error in
            if success, let userData = model {
                    completion(true, userData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: -  DriverFutureRidePaymentAPI
    func requestForDriverFutureRidePaymentAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, RideChargesPaymentPreviewData?, String?) -> ()) {
        RideChargesPreviewServices.requestForDriverFutureRidePaymentAPIServices(perams){ success, model, error in
            if success, let userData = model {
                completion(true, userData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: -  DriverFutureRideCompleteAPI
    func requestForDriverFutureRideCompleteAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, RideChargesPreviewData?, String?) -> ()) {
        RideChargesPreviewServices.requestForDriverFutureRideCompleteAPIServices(perams){ success, model, error in
            if success, let userData = model {
                completion(true, userData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
}
