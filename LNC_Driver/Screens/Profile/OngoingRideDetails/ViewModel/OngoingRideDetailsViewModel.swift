//
//  OngoingRideDetailsViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 01/10/22.
//

import Foundation
class OngoingRideDetailsViewModel: NSObject {
    
    private var ongoingRideDetailsServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.ongoingRideDetailsServices = ApiService
    }
    
    //MARK: - driverAdditionalStopsAPIwithDriverID
    func requestFordriverAdditionalStopsAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, driverAdditionalStopsData?, String?) -> ()) {
        ongoingRideDetailsServices.requestFordriverAdditionalStopsAPIServices(perams){ success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.message ?? "")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - WaitingChargesStartAPI
    func requestForWaitingChargesStartAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, WaitingChargesStartData?, String?) -> ()) {
        ongoingRideDetailsServices.requestForWaitingChargesStartAPIServices(perams){ success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.message ?? "")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - driverwaiting time APIwithDriverID
    func requestForDriverWaitingTimeAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, driverWaitingTimeData?, String?) -> ()) {
        ongoingRideDetailsServices.requestForDriverWaitingTimeAPIServices(perams){ success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.message ?? "")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - AdditionalStopswaitingtime
    func requestForAdditionalStopswaitingtimeAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, AdditionalStopswaitingtimeData?, String?) -> ()) {
        ongoingRideDetailsServices.requestForAdditionalStopswaitingtimeAPIServices(perams){ success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.message ?? "")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    //MARK: - DriverRideCompleteAPI
    func requestForDriverRideCompleteAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, DriverRideCompleteData?, String?) -> ()) {
        ongoingRideDetailsServices.requestForDriverRideCompleteAPIServices(perams){ success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.message ?? "")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - DriverRideStartAPI
    func requestForDriverRideStartAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, DriverRideStartData?, String?) -> ()) {
        ongoingRideDetailsServices.requestForDriverRideStartAPIServices(perams){ success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.message ?? "")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - DriverFutureRideDetailsAPI
    func requestForDriverFutureRideDetailsAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, DriverFutureRideDetailsData?, String?) -> ()) {
        ongoingRideDetailsServices.requestForDriverFutureRideDetailsAPIServices(perams){ success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.message ?? "")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }

    
    //MARK: - PartnerFutureRideDetailsAPI
    func requestForPartnerFutureRideDetailsAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, PartnerFutureRideDetailsData?, String?) -> ()) {
        ongoingRideDetailsServices.requestForPartnerFutureRideDetailsAPIServices(perams){ success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.message ?? "")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - DriverRidePaymentAPI
    func requestForDriverRidePaymentAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, DriverRidePaymentData?, String?) -> ()) {
        ongoingRideDetailsServices.requestForDriverRidePaymentAPIServices(perams){ success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.message ?? "")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - IntimateToPartnerStartRideAPI
    func requestForIntimateToPartnerStartRideAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, IntimateToPartnerStartRideData?, String?) -> ()) {
        ongoingRideDetailsServices.requestForIntimateToPartnerStartRideAPIServices(perams){ success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.message ?? "")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
