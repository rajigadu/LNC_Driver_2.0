//
//  AddManagePartnersViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import Foundation
import UIKit

class AddManagePartnersViewModel: NSObject {
    
    private var AddManagePartnersServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.AddManagePartnersServices = ApiService
    }
    
    func requestForAddManagePartnersServices(perams: Dictionary<String,String>, completion: @escaping (Bool, AddManagePartnersData?, String?) -> ()) {
        AddManagePartnersServices.requestForAddManagePartnersServices(perams){ success, model, error in
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
