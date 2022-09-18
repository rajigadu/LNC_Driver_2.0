//
//  RegistrationUser.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 13/09/22.
//

import Foundation

typealias RegistrationUserData = RegistrationUserDetails

struct RegistrationUserDetails : Codable {
    let userData : [RegistrationUserDatar]?
    let loginStatus : String?
    enum CodingKeys: String, CodingKey {

        case userData = "data"
        case loginStatus = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userData = try values.decodeIfPresent([RegistrationUserDatar].self, forKey: .userData)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
    }

}

struct RegistrationUserDatar : Codable {
    let Message : String?

    enum CodingKeys: String, CodingKey {

        case Message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Message = try values.decodeIfPresent(String.self, forKey: .Message)
    }

}


struct registartionStruct {
     var str_fname: String?
    var str_lname: String?
    var str_email: String?
    var str_mobile: String?
    var str_password: String?
    var str_vtype: String?
    var str_makingyear: String?
    var str_vmodel: String?
    var str_address: String?
}

