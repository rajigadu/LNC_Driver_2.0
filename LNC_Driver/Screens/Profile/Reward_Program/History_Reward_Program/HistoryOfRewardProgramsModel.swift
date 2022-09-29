//
//  HistoryOfRewardProgramsModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import Foundation
typealias HistoryOfRewardProgramsData = HistoryOfRewardProgramsModel

struct HistoryOfRewardProgramsModel : Codable {
    let message : String?
    let status : String?
    let data : [HistoryOfRewardProgramsDatar]?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent([HistoryOfRewardProgramsDatar].self, forKey: .data)
    }

}

struct HistoryOfRewardProgramsDatar : Codable {
    let otherdate : String?
    let time : String?
    let pickup_address : String?
    let drop_address : String?
    let distance : String?
    let point : String?

    enum CodingKeys: String, CodingKey {

        case otherdate = "otherdate"
        case time = "time"
        case pickup_address = "pickup_address"
        case drop_address = "drop_address"
        case distance = "craeted_date"
        case point = "point"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        otherdate = try values.decodeIfPresent(String.self, forKey: .otherdate)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        pickup_address = try values.decodeIfPresent(String.self, forKey: .pickup_address)
        drop_address = try values.decodeIfPresent(String.self, forKey: .drop_address)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        point = try values.decodeIfPresent(String.self, forKey: .point)
    }

}
