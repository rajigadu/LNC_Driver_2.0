//
//  ProfileViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 15/09/22.
//

import Foundation
import UIKit

class ProfileViewModel: NSObject {
    
    private var ProfileServices: LateNightChauffeursDriverServiceProtocol
        
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.ProfileServices = ApiService
    }
    
    func requestForEditProfileServices(perams: Dictionary<String,String>, picImage: UIImage, fileName: String, profileStruct : uploadImage, completion: @escaping (Bool, ProfileUserData?, String?) -> ()) {
        ProfileServices.requestForEditProfileServices(perams, picImage: picImage, fileName: fileName, profileStruct: profileStruct) { success, model, error in
            if success, let EditProfileUserData = model {
                if EditProfileUserData.loginStatus == "1" {
                    UserDefaults.standard.set(EditProfileUserData.userData?[0].FName, forKey: "DriverFirstName")
                    UserDefaults.standard.set(EditProfileUserData.userData?[0].LName, forKey: "DriverLasttName")
                    UserDefaults.standard.set(EditProfileUserData.userData?[0].MobileNumber, forKey: "DriverMobilenumber")
                    UserDefaults.standard.set(API_URl.API_IMAGEBASE_URL + (EditProfileUserData.userData?[0].profilePic ?? ""), forKey: "DriverProfilepic")
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