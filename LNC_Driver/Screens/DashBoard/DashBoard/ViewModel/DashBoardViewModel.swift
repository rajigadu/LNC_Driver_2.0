//
//  DashBoardViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 06/10/22.
//

import Foundation
import UIKit

class DashBoardViewModel: NSObject {
    
    private var dashBoardServices: LateNightChauffeursDriverServiceProtocol
        
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.dashBoardServices = ApiService
    }
    
    //MARK: - NextRIDETime
    func requestForNextRIDETimeAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, DashBoardNextRideData?, String?) -> ()) {
        dashBoardServices.requestForNextRIDETimeAPIServices(perams) { success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.message ?? "Something went wrong")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - get google key
    func requestForgetgooglekeyListAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, DashBoardUserData?, String?) -> ()) {
        dashBoardServices.requestForgetgooglekeyListAPIServices(perams) { success, model, error in
            if success, let UserData = model {
                if UserData.status == "1" {
                    completion(true, UserData, nil)
                } else {
                    completion(false, nil, UserData.msg ?? "")
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}


