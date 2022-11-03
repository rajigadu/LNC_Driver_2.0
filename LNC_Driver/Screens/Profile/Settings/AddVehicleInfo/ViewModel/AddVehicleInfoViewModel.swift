//
//  AddVehicleInfoViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 15/09/22.
//

import Foundation
import UIKit

class AddVehicleInfoViewModel: NSObject {
    
    private var ProfileServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.ProfileServices = ApiService
    }
    
    func requestForGetVehicleDetailsServices(perams: Dictionary<String,String>, completion: @escaping (Bool, GetVehicleData?, String?) -> ()) {
        ProfileServices.requestForGetVehicleDetailsServices(perams){ success, model, error in
            if success, let EditProfileUserData = model {
                completion(true, EditProfileUserData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func requestForPostVehicleDetailsServices(_ params: [String: String],vehicle_image_name: String, vehicle_image: UIImage,documents_image_name: String, documents_image: UIImage,license_image_name: String, license_image: UIImage,driver_abstract_name: String, driver_abstract: UIImage, vehicleImageStruct:uploadImage, documentImageStruct:uploadImage, licenseImageStruct:uploadImage, driverAbstactImageStruct:uploadImage,  completion: @escaping (Bool, EditVehicleDataModel2?, String?) -> ()) {
        
        
        HttpRequestHelper().uploadEditVehicleImagePOST(url: API_URl.API_EDITVEHICLEINFO_URL, params: params,vehicle_image_name: vehicle_image_name, vehicle_image: vehicle_image,documents_image_name: documents_image_name, documents_image: documents_image,license_image_name: license_image_name, license_image: license_image,driver_abstract_name: driver_abstract_name, driver_abstract: driver_abstract, httpHeader: .application_x_www_form_urlencoded, vehicleImageStruct:vehicleImageStruct,documentImageStruct:documentImageStruct,licenseImageStruct:licenseImageStruct,driverAbstactImageStruct:driverAbstactImageStruct) { success, model, error in
        
            if success, let PostVehicleDetails = model {
                    completion(true, PostVehicleDetails, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
