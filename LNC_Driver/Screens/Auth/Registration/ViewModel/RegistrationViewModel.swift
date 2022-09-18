//
//  RegistrationViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 13/09/22.
//

import Foundation
import UIKit

class RegistrationViewModel: NSObject {
    
    private var RegistrationServices: LateNightChauffeursDriverServiceProtocol
        
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.RegistrationServices = ApiService
    }
    
    func requestForRegistrationServices(_ perams: Dictionary<String, String>,peramsModel :registartionStruct, profilepic_name: String, profilepic: UIImage,vehicle_image_name: String, vehicle_image: UIImage,documents_image_name: String, documents_image: UIImage,license_image_name: String, license_image: UIImage,driver_abstract_name: String, driver_abstract: UIImage, completion: @escaping (Bool, RegistrationUserData?, String?) -> ()) {
        
        RegistrationServices.requestForRegistrationServices(perams, peramsModel :peramsModel, profilepic_name: profilepic_name, profilepic: profilepic,vehicle_image_name: vehicle_image_name, vehicle_image: vehicle_image,documents_image_name: documents_image_name, documents_image: documents_image,license_image_name: license_image_name, license_image: license_image,driver_abstract_name: driver_abstract_name, driver_abstract: driver_abstract) { success, model, error in
            if success, let RegistrationUserData = model {
                if RegistrationUserData.loginStatus == "1" {
                    completion(true, RegistrationUserData, nil)
                } else {
                    completion(false, nil, RegistrationUserData.userData?[0].Message)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
}
