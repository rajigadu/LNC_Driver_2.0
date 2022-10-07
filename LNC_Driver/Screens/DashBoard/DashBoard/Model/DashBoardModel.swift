//
//  DashBoardModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 06/10/22.
//

import Foundation

typealias DashBoardNextRideData = DashBoardNextRideModel

struct DashBoardNextRideModel : Codable {
    let time_left : String?
    let status : String?
    let message : String?
    enum CodingKeys: String, CodingKey {

        case time_left = "time_left"
        case status = "status"
        case message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        time_left = try values.decodeIfPresent(String.self, forKey: .time_left)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

typealias DashBoardUserData = DashBoardUserModel

struct DashBoardUserModel : Codable {
    let data : DashBoardUserDatar?
    let msg : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(DashBoardUserDatar.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct DashBoardUserDatar : Codable {
    let id : String?
    let key : String?
    let status : String?
    let created_date : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case key = "key"
        case status = "status"
        case created_date = "created_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_date = try values.decodeIfPresent(String.self, forKey: .created_date)
    }

}
