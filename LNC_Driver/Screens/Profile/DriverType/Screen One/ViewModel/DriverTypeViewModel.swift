//
//  DriverTypeViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import Foundation
import UIKit

class DriverTypeViewModel: NSObject {
    
    private var driverTypeServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.driverTypeServices = ApiService
    }
    
    //MARK: - ActivePartnerAPI
    func requestForActivePartnerAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, DriverTypeData?, String?) -> ()) {
        driverTypeServices.requestForActivePartnerAPIServices(perams){ success, model, error in
            if success, let EditProfileUserData = model {
                if EditProfileUserData.status == "1" {
                    completion(true, EditProfileUserData, nil)
                } else {
                    completion(false, nil, EditProfileUserData.msg)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: -  selectDriverTypeAPI
    func requestForSelectDriverTypeAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, AddNewPartnerListData?, String?) -> ()) {
        driverTypeServices.requestForSelectDriverTypeAPIServices(perams){ success, model, error in
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
    
    //MARK: - LookingForPartnerAPI
    func requestForLookingForPartnerAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, UpdateManagePartnersData?, String?) -> ()) {
        driverTypeServices.requestForLookingForPartnerAPIServices(perams){ success, model, error in
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
    
    //MRK:- PartnerListAPI
    func requestForPartnerListAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, PartnerListData?, String?) -> ()) {
        driverTypeServices.requestForPartnerListAPIServices(perams){ success, model, error in
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
