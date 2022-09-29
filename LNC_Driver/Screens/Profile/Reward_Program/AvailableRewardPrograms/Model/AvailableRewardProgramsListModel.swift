//
//  AvailableRewardProgramsListModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import Foundation

typealias AvailableRewardProgramsListData = AvailableRewardProgramsListModel

struct AvailableRewardProgramsListModel : Codable {
    let message : String?
    let status : String?
    let data : [AvailableRewardProgramsListDatar]?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent([AvailableRewardProgramsListDatar].self, forKey: .data)
    }

}

struct AvailableRewardProgramsListDatar : Codable {
    let Program : [AvailableReward_Program]?
 
    enum CodingKeys: String, CodingKey {
         case Program = "Program"
     }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Program = try values.decodeIfPresent([AvailableReward_Program].self, forKey: .Program)
     }
}

struct AvailableReward_Program : Codable {
    let pname : String?
    let pdescription : String?
    let id : String?
 
    enum CodingKeys: String, CodingKey {
         case pname = "pname"
         case pdescription = "pdescription"
         case id = "id"
     }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pname = try values.decodeIfPresent(String.self, forKey: .pname)
        pdescription = try values.decodeIfPresent(String.self, forKey: .pdescription)
        id = try values.decodeIfPresent(String.self, forKey: .id)
     }

}


typealias ActivateRewardProgramData = ActivateRewardProgramDataModel

struct ActivateRewardProgramDataModel : Codable {
    let message : String?
    let status : String?
 
    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
