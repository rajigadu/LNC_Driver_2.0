//
//  DBHFeedbackViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 19/03/23.
//

import Foundation
import UIKit

class DBHFeedbackViewModel: NSObject {
    
    private var DBHFeedbackServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.DBHFeedbackServices = ApiService
    }
    
    //MARK: - Feedback API
    func requestForDBHRideFeedbackAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, FeedBacData?, String?) -> ()) {
        DBHFeedbackServices.requestForDBHRideFeedbackAPIServices(perams){ success, model, error in
            if success, let userFeedBackData = model {
                     completion(true, userFeedBackData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
