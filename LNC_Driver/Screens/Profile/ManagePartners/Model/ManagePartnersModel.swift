//
//  ManagePartnersModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import Foundation

typealias ManagePartnersData = ManagePartnersModel
struct ManagePartnersModel : Codable {
    let message : String?
    let status : String?
    let data : [ManagePartnersDatar]?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent([ManagePartnersDatar].self, forKey: .data)
    }

}

struct ManagePartnersDatar : Codable {
    let id : String?
    let partner_name : String?
    let partner_email : String?
    let partner_phone : String?
    let default_status : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case partner_name = "partner_name"
        case partner_email = "partner_email"
        case partner_phone = "partner_phone"
        case default_status = "default_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        partner_name = try values.decodeIfPresent(String.self, forKey: .partner_name)
        partner_email = try values.decodeIfPresent(String.self, forKey: .partner_email)
        partner_phone = try values.decodeIfPresent(String.self, forKey: .partner_phone)
        default_status = try values.decodeIfPresent(String.self, forKey: .default_status)
    }

}


typealias UpdateManagePartnersData = UpdateManagePartnersModel
struct UpdateManagePartnersModel : Codable {
    let message : String?
    let status : String?
    let data : [UpdateManagePartnersDatar]?

    enum CodingKeys: String, CodingKey {

        case message = "msg"
        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent([UpdateManagePartnersDatar].self, forKey: .data)
    }

}

struct UpdateManagePartnersDatar : Codable {
    let message : String?

    enum CodingKeys: String, CodingKey {

        case message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

