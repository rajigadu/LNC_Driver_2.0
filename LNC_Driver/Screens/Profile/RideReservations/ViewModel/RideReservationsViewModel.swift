//
//  RideReservationsViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 30/09/22.
//

import Foundation
import UIKit

class RideReservationsViewModel: NSObject {
    
    private var rideReservationsServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.rideReservationsServices = ApiService
    }
    
    //MARK: - DriverfutureRideListAPI
    func requestFordriverfutureRideListAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, RideReservationsData?, String?) -> ()) {
        rideReservationsServices.requestFordriverfutureRideListAPIServices(perams){ success, model, error in
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
    
    //MARK: -  PartnerfutureRideListAPI
    func requestForpartnerfutureRideListAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, RideReservationsData?, String?) -> ()) {
        rideReservationsServices.requestForPartnerfutureRideListAPIServices(perams){ success, model, error in
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
    
    //MARK: - DriverAcceptfutureRideAPI
    func requestdriverAcceptFutureRideAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, AcceptedRideReservationsData?, String?) -> ()) {
        rideReservationsServices.requestdriverAcceptFutureRideAPIServices(perams){ success, model, error in
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
    
    //MRK:- partnerAcceptfutureRideAPI
    func requestForPartnerAcceptFutureRideAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, AcceptedRideReservationsData?, String?) -> ()) {
        rideReservationsServices.requestForPartnerAcceptFutureRideAPIServices(perams){ success, model, error in
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
    
    //MARK: - Aleready Accepted ride time bases --showing accepted button as partner
    //MARK: - PartnerfutureRideAccepetedListAPI
    func requestForpartnerAcceptedFutureRideAcceptedListAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, AlereadyAcceptedridetimebasesData?, String?) -> ()) {
        rideReservationsServices.requestForpartnerAcceptedFutureRideAcceptedListAPIServices(perams){ success, model, error in
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
    
    //MARK: - Aleready Accepted ride time bases --showing accepted button as Driver
    //MARK: - DriverfutureRideAccepetedListAPI
    //MARK: - DriverfutureRideListAPI
    func requestFordriverfutureRideListAcceptedAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, AlereadyAcceptedridetimebasesData?, String?) -> ()) {
        rideReservationsServices.requestFordriverfutureRideListAcceptedAPIServices(perams){ success, model, error in
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
