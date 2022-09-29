//
//  ActivatedRewardProgramsModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import Foundation
typealias ActivatedRewardProgramsData = ActivatedRewardProgramsModel

struct ActivatedRewardProgramsModel : Codable {
    let message : String?
    let status : String?
    let data : [ActivatedRewardProgramsDatar]?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent([ActivatedRewardProgramsDatar].self, forKey: .data)
    }

}

struct ActivatedRewardProgramsDatar : Codable {
    let target : String?
    let bonus : String?
    let total : String?
    let pname : String?
    let craeted_date : String?
    let id : String?
    let driver_time : String?

    enum CodingKeys: String, CodingKey {

        case target = "target"
        case bonus = "bonus"
        case total = "total"
        case pname = "pname"
        case craeted_date = "craeted_date"
        case id = "id"
        case driver_time = "driver_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        target = try values.decodeIfPresent(String.self, forKey: .target)
        bonus = try values.decodeIfPresent(String.self, forKey: .bonus)
        total = try values.decodeIfPresent(String.self, forKey: .total)
        pname = try values.decodeIfPresent(String.self, forKey: .pname)
        craeted_date = try values.decodeIfPresent(String.self, forKey: .craeted_date)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        driver_time = try values.decodeIfPresent(String.self, forKey: .driver_time)
    }

}
