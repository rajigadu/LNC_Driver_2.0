//
//  AppDelegateModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 08/10/22.
//

import Foundation

class ChatNotificationData : Codable {
    
        var message: String?
        var userid: String?
        var driverid: String?
        var partnerid: String?
        var user: String?
        var ride: String?
    
    var str_RideIDr:String?
    var str_UserIDr: String?
    var str_SelectedDriverFirstNameget: String?
    var str_SelectedDriverLastNameget: String?
    var str_SelectedDriverProfilepicget: String?
    
    var swap_rol_partner: String?
    var swap_rol_driver: String?
    init() {}
    
    private enum CodingKeys: String, CodingKey {
        case message
        case userid
        case driverid
        case partnerid
        case user
        case ride
        
        case str_RideIDr = "rideid"
        case str_UserIDr = "driver_id_for_future_ride"
        case str_SelectedDriverFirstNameget = "first_name"
        case str_SelectedDriverLastNameget = "last_name"
        case str_SelectedDriverProfilepicget = "profile_pic"
        
        case swap_rol_partner = "swap_rol_partner"
        case swap_rol_driver = "swap_rol_driver"
    }

    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
               if let message = try container.decodeIfPresent(String.self, forKey: .message) {
                   self.message = message
               }
        
        if let userid = try container.decodeIfPresent(String.self, forKey: .userid) {
            self.userid = userid
        }
        
        if let partnerId = try container.decodeIfPresent(String.self, forKey: .partnerid) {
            self.partnerid = partnerId
        }
        if let driver_id = try container.decodeIfPresent(String.self, forKey: .driverid) {
            self.driverid = driver_id
        }
        if let user = try container.decodeIfPresent(String.self, forKey: .user) {
            self.user = user
        }
        if let ride = try container.decodeIfPresent(String.self, forKey: .ride) {
            self.ride = ride
        }
        
        if let str_RideIDr = try container.decodeIfPresent(String.self, forKey: .str_RideIDr) {
            self.str_RideIDr = str_RideIDr
        }
        if let str_UserIDr = try container.decodeIfPresent(String.self, forKey: .str_UserIDr) {
            self.str_UserIDr = driverid
        }
        if let str_SelectedDriverFirstNameget = try container.decodeIfPresent(String.self, forKey: .str_SelectedDriverFirstNameget) {
            self.str_SelectedDriverFirstNameget = str_SelectedDriverFirstNameget
        }
        if let str_SelectedDriverLastNamegetride = try container.decodeIfPresent(String.self, forKey: .str_SelectedDriverLastNameget) {
            self.str_SelectedDriverLastNameget = str_SelectedDriverLastNamegetride
        }
        if let str_SelectedDriverProfilepicget = try container.decodeIfPresent(String.self, forKey: .str_SelectedDriverProfilepicget) {
            self.str_SelectedDriverProfilepicget = str_SelectedDriverProfilepicget
        }
        
        if let swap_rol_Partner = try container.decodeIfPresent(String.self, forKey: .swap_rol_partner) {
            self.swap_rol_partner = swap_rol_Partner
        }
        
        if let swap_rol_Driver = try container.decodeIfPresent(String.self, forKey: .swap_rol_driver) {
            self.swap_rol_driver = swap_rol_Driver
        }
        
    }
    
    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        try container.encode(userid, forKey: .userid)
         try container.encode(driverid, forKey: .driverid)
        try container.encode(partnerid, forKey: .partnerid)
         try container.encode(user, forKey: .user)
        try container.encode(ride, forKey: .ride)
        
        try container.encode(swap_rol_partner, forKey: .swap_rol_partner)
       try container.encode(swap_rol_driver, forKey: .swap_rol_driver)

        
        try container.encode(str_RideIDr, forKey: .str_RideIDr)
        try container.encode(str_UserIDr, forKey: .str_UserIDr)
         try container.encode(str_SelectedDriverFirstNameget, forKey: .str_SelectedDriverFirstNameget)
         try container.encode(str_SelectedDriverLastNameget, forKey: .str_SelectedDriverLastNameget)
        try container.encode(str_SelectedDriverProfilepicget, forKey: .str_SelectedDriverProfilepicget)
     }
}
