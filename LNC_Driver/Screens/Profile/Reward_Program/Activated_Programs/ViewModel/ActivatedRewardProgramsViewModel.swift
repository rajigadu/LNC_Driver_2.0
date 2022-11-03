//
//  ActivatedRewardProgramsViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import Foundation
import UIKit

class ActivatedRewardProgramsViewModel: NSObject {
    
    private var activatedRewardProgramsServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.activatedRewardProgramsServices = ApiService
    }
    
    func requestForActivatedRewardProgramsServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ActivatedRewardProgramsData?, String?) -> ()) {
        activatedRewardProgramsServices.requestForActivatedRewardProgramsServices(perams){ success, model, error in
            if success, let ActivatedRewardProgram = model {
                completion(true, ActivatedRewardProgram, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
