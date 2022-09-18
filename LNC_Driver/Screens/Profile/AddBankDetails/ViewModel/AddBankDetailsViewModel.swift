//
//  AddBankDetailsViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 15/09/22.
//

import Foundation
import UIKit

class AddBankDetailsViewModel: NSObject {
    
    private var ProfileServices: LateNightChauffeursDriverServiceProtocol
        
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.ProfileServices = ApiService
    }
    
    func requestForAddBankDetailsServices(perams: Dictionary<String,String>, completion: @escaping (Bool, AddBankDetailsUserData?, String?) -> ()) {
        ProfileServices.requestForAddBankDetailsServices(perams){ success, model, error in
            if success, let AddBankDetailsModel = model {
                if AddBankDetailsModel.loginStatus == "1" {
                    completion(true, AddBankDetailsModel, nil)
                } else {
                    completion(false, nil, AddBankDetailsModel.message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func requestForGetBankDetailsServices(perams: Dictionary<String,String>, completion: @escaping (Bool, GetBankDetailsData?, String?) -> ()) {
        ProfileServices.requestForGetBankDetailsServices(perams){ success, model, error in
            if success, let GetBankDetailsModel = model {
                if GetBankDetailsModel.loginStatus == "1" {
                    completion(true, GetBankDetailsModel, nil)
                } else {
                    completion(false, nil, GetBankDetailsModel.message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
