//
//  HistoryOfRewardProgramsViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import Foundation
import UIKit

class HistoryOfRewardProgramsViewModel: NSObject {
    
    private var historyOfRewardProgramsServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.historyOfRewardProgramsServices = ApiService
    }
    
    func requestForHistoryOfRewardProgramsServices(perams: Dictionary<String,String>, completion: @escaping (Bool, HistoryOfRewardProgramsData?, String?) -> ()) {
        historyOfRewardProgramsServices.requestForHistoryOfRewardProgramsServices(perams){ success, model, error in
            if success, let HistoryOfRewardProgramUserData = model {
                completion(true, HistoryOfRewardProgramUserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
