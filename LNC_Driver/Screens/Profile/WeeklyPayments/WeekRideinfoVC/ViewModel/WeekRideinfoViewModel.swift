//
//  WeekRideinfoViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import Foundation
import UIKit

class WeekRideinfoViewModel: NSObject {
    
    private var WeekRideinfoServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.WeekRideinfoServices = ApiService
    }
    
    func requestForWeekRideinfoServices(perams: Dictionary<String,String>, completion: @escaping (Bool, WeekRideinfoData?, String?) -> ()) {
        WeekRideinfoServices.requestForGetWeeklyPaymentsInfolistServices(perams){ success, model, error in
            if success, let UserData = model {
                completion(true, UserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
}
