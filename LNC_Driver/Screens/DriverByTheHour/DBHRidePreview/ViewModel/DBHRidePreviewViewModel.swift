//
//  DBHRidePreviewViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 16/03/23.
//

import Foundation
import UIKit

class DBHRidePreviewViewModel : NSObject {
    
    var DBHRideReservationService : LateNightChauffeursDriverServiceProtocol
    
    required init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.DBHRideReservationService = ApiService
    }
    
    func DbhRideStartApiIntigration(perams: [String: String], complete: @escaping (Bool, DbhRideStartData?,String?)-> ()) {
        DBHRideReservationService.requestForDbhRidestartApiServices(perams){ success, model, error in
            if success, let UserData = model {
               complete(true,UserData,nil)
            } else {
                complete(false, nil, error)
            }
        }
    }
    
    func DbhRideEndApiIntigration(perams: [String: String], complete: @escaping (Bool, DbhEndRideData?,String?)-> ()) {
        DBHRideReservationService.requestForDbhRideEndApiServices(perams){ success, model, error in
            if success, let UserData = model {
               complete(true,UserData,nil)
            } else {
                complete(false, nil, error)
            }
        }
    }
}
