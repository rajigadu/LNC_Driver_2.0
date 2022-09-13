//
//  LoginUser.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation

typealias UserData = LoginedUser

// MARK: - LoginedUser Details
struct LoginedUser : Codable {
    
    let message : String?
    let loginStatus : String?
    let userDetails : [LoginedUserData]?

    enum CodingKeys: String, CodingKey {

        case message = "msg"
        case loginStatus = "status"
        case userDetails = "data"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
        userDetails = try values.decodeIfPresent([LoginedUserData].self, forKey: .userDetails)
    }

}

struct LoginedUserData : Codable {
    
    let userId : String?
    let first_name : String?
    let last_name : String?
    let email : String?
    let profile_pic : String?
    let mobile : String?
    let status : String?
    let driver_type : String?
    let approved_status : String?
    let login_status : String?
    let date_created : String?
    let rating : String?

    enum CodingKeys: String, CodingKey {
        
        case userId = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case email = "email"
        case profile_pic = "profile_pic"
        case mobile = "mobile"
        case status = "status"
        case driver_type = "driver_type"
        case approved_status = "approved_status"
        case login_status = "login_status"
        case date_created = "date_created"
        case rating = "rating"
    }

    init(from decoder: Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        driver_type = try values.decodeIfPresent(String.self, forKey: .driver_type)
        approved_status = try values.decodeIfPresent(String.self, forKey: .approved_status)
        login_status = try values.decodeIfPresent(String.self, forKey: .login_status)
        date_created = try values.decodeIfPresent(String.self, forKey: .date_created)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
     }
}
