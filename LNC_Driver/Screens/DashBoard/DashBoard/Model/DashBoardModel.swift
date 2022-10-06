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
