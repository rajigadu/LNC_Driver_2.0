//
//  ManagePartnersViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import Foundation
import UIKit

class ManagePartnersViewModel: NSObject {
    
    private var ManagePartnersServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.ManagePartnersServices = ApiService
    }
    
    func requestForManagePartnersServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ManagePartnersData?, String?) -> ()) {
        ManagePartnersServices.requestForManagePartnersServices(perams){ success, model, error in
            if success, let ManagePartnersUserData = model {
                completion(true, ManagePartnersUserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func requestForUpdatePartnerStatusService(perams: Dictionary<String,String>, completion: @escaping (Bool, UpdateManagePartnersData?, String?) -> ()) {
        ManagePartnersServices.requestForUpdatePartnerStatusService(perams){ success, model, error in
            if success, let UpdatePartnerStatus = model {
                completion(true, UpdatePartnerStatus, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
