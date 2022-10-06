//
//  FeedbackViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 02/10/22.
//

import Foundation
import Foundation
import UIKit

class FeedbackViewModel: NSObject {
    
    private var FeedbackServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.FeedbackServices = ApiService
    }
    
    //MARK: - Feedback API
    func requestForFeedbackAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, FeedBacData?, String?) -> ()) {
        FeedbackServices.requestForFeedbackAPIServices(perams){ success, model, error in
            if success, let userData = model {
                if userData.status == "1" {
                    completion(true, userData, nil)
                } else {
                    completion(false, nil, userData.message ?? "")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
