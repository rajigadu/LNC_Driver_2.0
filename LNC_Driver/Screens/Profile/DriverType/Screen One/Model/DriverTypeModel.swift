//
//  DriverTypeModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import Foundation

typealias DriverTypeData = DriverTypeModel
struct DriverTypeModel : Codable {
    let msg : String?
    let status : String?
    let data : DriverTypeDatar?

    enum CodingKeys: String, CodingKey {

        case msg = "msg"
        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent(DriverTypeDatar.self, forKey: .data)
    }
}

struct DriverTypeDatar : Codable {
    let id : String?
    let partner_name : String?
    let partner_phone : String?
    let partner_email : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case partner_name = "partner_name"
        case partner_phone = "partner_phone"
        case partner_email = "partner_email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        partner_name = try values.decodeIfPresent(String.self, forKey: .partner_name)
        partner_phone = try values.decodeIfPresent(String.self, forKey: .partner_phone)
        partner_email = try values.decodeIfPresent(String.self, forKey: .partner_email)
    }

}

typealias PartnerListData = PartnerListModel
struct PartnerListModel : Codable {
    let message : String?
    let status : String?
    let data : [DriverTypeDatar]?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case data = "partnerData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent([DriverTypeDatar].self, forKey: .data)
    }

}


typealias AddNewPartnerListData = AddNewPartnerListModel
struct AddNewPartnerListModel : Codable {
    let message : String?
    let status : String?
    let data : [AddNewPartnerListDatar]?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent([AddNewPartnerListDatar].self, forKey: .data)
    }

}
struct AddNewPartnerListDatar : Codable {
    let message : String?
    let service_type : String?

    enum CodingKeys: String, CodingKey {

        case message = "msg"
        case service_type = "service_type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        service_type = try values.decodeIfPresent(String.self, forKey: .service_type)
    }

}
