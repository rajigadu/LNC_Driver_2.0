//
//  AvailableRewardProgramsListViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import Foundation
import UIKit

class AvailableRewardProgramsListViewModel: NSObject {
    
    private var availableRewardProgramsListServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.availableRewardProgramsListServices = ApiService
    }
    
    func requestForAvailableRewardProgramsListServices(perams: Dictionary<String,String>, completion: @escaping (Bool, AvailableRewardProgramsListData?, String?) -> ()) {
        availableRewardProgramsListServices.requestForAvailableRewardProgramsListServices(perams){ success, model, error in
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
    
    func requestForActivateRewardServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ActivateRewardProgramData?, String?) -> ()) {
        availableRewardProgramsListServices.requestForActivateRewardServices(perams){ success, model, error in
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