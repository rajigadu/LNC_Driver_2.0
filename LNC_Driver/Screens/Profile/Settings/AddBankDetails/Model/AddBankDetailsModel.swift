//
//  AddBankDetailsModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 15/09/22.
//

import Foundation

typealias AddBankDetailsUserData = AddBankDetailsUserModel

struct AddBankDetailsUserModel : Codable {
    let loginStatus : String?
    let message : String?
    enum CodingKeys: String, CodingKey {
        
        case loginStatus = "status"
        case message = "msg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}


typealias GetBankDetailsData = GetBankDetailsModel

struct GetBankDetailsModel : Codable {
    let loginStatus : String?
    let message : String?
    let userData : [GetBankDeatilsDatar]?
    enum CodingKeys: String, CodingKey {
        case userData = "data"
        case loginStatus = "status"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        userData = try values.decodeIfPresent([GetBankDeatilsDatar].self, forKey: .userData)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

struct GetBankDeatilsDatar : Codable {
    
    let id: String?
    let driver_id: String?
    let fname: String?
    let lname: String?
    let bank_name: String?
    let mobile: String?
    let accnumber: String?
    let recored_type: String?
    let batch_description: String?
    let routingnumber: String?
    let npcAccount: String?
    let type: String?
    let date_updated: String?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case driver_id = "driver_id"
        case fname = "fname"
        case lname = "lname"
        case bank_name = "bank_name"
        case mobile = "mobile"
        case accnumber = "accnumber"
        case recored_type = "recored_type"
        case batch_description = "batch_description"
        case routingnumber = "routingnumber"
        case npcAccount = "npcAccount"
        case type = "type"
        case date_updated = "date_updated"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        driver_id = try values.decodeIfPresent(String.self, forKey: .driver_id)
        fname = try values.decodeIfPresent(String.self, forKey: .fname)
        lname = try values.decodeIfPresent(String.self, forKey: .lname)
        bank_name = try values.decodeIfPresent(String.self, forKey: .bank_name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        accnumber = try values.decodeIfPresent(String.self, forKey: .accnumber)
        recored_type = try values.decodeIfPresent(String.self, forKey: .recored_type)
        batch_description = try values.decodeIfPresent(String.self, forKey: .batch_description)
        routingnumber = try values.decodeIfPresent(String.self, forKey: .routingnumber)
        npcAccount = try values.decodeIfPresent(String.self, forKey: .npcAccount)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        date_updated = try values.decodeIfPresent(String.self, forKey: .date_updated)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}
