//
//  WeeklyPaymentsViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import Foundation
import UIKit

class WeeklyPaymentsViewModel: NSObject {
    
    private var WeeklyPaymentsServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.WeeklyPaymentsServices = ApiService
    }
    
    func requestForWeeklyPaymentsServices(perams: Dictionary<String,String>, completion: @escaping (Bool, WeeklyPaymentsWeekData?, String?) -> ()) {
        WeeklyPaymentsServices.requestForGetWeeklyPaymentslistServices(perams){ success, model, error in
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
