//
//  ListOfAssignRidesViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 16/03/23.
//

import Foundation

class ListOfAssignRidesViewModel: NSObject {
    
    private var ListOfAssignRidesServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.ListOfAssignRidesServices = ApiService
    }
    
    //MARK: - List Of Assign Rides For DBH
    func requestForDBHAssignRideListAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ListOfAssignRidesData?, String?) -> ()) {
        ListOfAssignRidesServices.requestForDBHAssignRideListAPIServices(perams){ success, model, error in
            if success, let ListOfAssignRidesList = model {
                completion(true, ListOfAssignRidesList, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
}
