//
//  AcceptedRidesInfoViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 01/10/22.
//

import Foundation
import UIKit

class AcceptedRidesInfoViewModel: NSObject {
    
    private var acceptedRidesInfoServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.acceptedRidesInfoServices = ApiService
    }
    
    //MARK: - DriverOnlineAPI
    func requestForDriverOnlineAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, RideReservationsData?, String?) -> ()) {
        acceptedRidesInfoServices.requestForDriverOnlineAPIServices(perams){ success, model, error in
            if success, let EditProfileUserData = model {
                if EditProfileUserData.status == "1" {
                    completion(true, EditProfileUserData, nil)
                } else {
                    completion(false, nil, EditProfileUserData.message ?? "")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: -  DriverRoleChangeAPI
    func requestForDriverRoleChangeAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, RideReservationsData?, String?) -> ()) {
        acceptedRidesInfoServices.requestForDriverRoleChangeAPIServices(perams){ success, model, error in
            if success, let EditProfileUserData = model {
                if EditProfileUserData.status == "1" {
                    completion(true, EditProfileUserData, nil)
                } else {
                    completion(false, nil, EditProfileUserData.message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - DriverfutureRideListAPI
    func requestForDriverAcceptedFutureRideListAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, RideReservationsData?, String?) -> ()) {
        acceptedRidesInfoServices.requestForDriverAcceptedFutureRideListAPIServices(perams){ success, model, error in
            if success, let EditProfileUserData = model {
                if EditProfileUserData.status == "1" {
                    completion(true, EditProfileUserData, nil)
                } else {
                    completion(false, nil, EditProfileUserData.message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - PartnerfutureRideListAPI
    func requestForpartnerAcceptedFutureRideListAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, RideReservationsData?, String?) -> ()) {
        acceptedRidesInfoServices.requestForpartnerAcceptedFutureRideListAPIServices(perams){ success, model, error in
            if success, let EditProfileUserData = model {
                if EditProfileUserData.status == "1" {
                    completion(true, EditProfileUserData, nil)
                } else {
                    completion(false, nil, EditProfileUserData.message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
