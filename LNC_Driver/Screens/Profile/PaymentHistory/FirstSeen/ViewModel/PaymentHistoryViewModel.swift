//
//  PaymentHistoryViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import Foundation
import UIKit

class PaymentHistoryViewModel: NSObject {
    
    private var paymentHistoryServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.paymentHistoryServices = ApiService
    }
    
    func requestForPaymentHistoryServices(perams: Dictionary<String,String>, completion: @escaping (Bool, PaymentHistoryData?, String?) -> ()) {
        paymentHistoryServices.requestForPaymentHistoryServices(perams){ success, model, error in
            if success, let EditProfileUserData = model {
                if EditProfileUserData.status == "1" {
                    completion(true, EditProfileUserData, nil)
                } else {
                    completion(false, nil, I18n.SomethingWentWrong)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
