//
//  DBHRidePreviewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 16/03/23.
//

import Foundation

typealias DbhRideStartData = DbhRideStartModel

struct DbhRideStartModel : Codable {
    
    var status : String?
    var msg: String?
    
    enum CodingKeys : String, CodingKey {
        
        case status = "status"
        case msg = "msg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.status = try values.decode(String.self, forKey: .status)
        self.msg = try values.decode(String.self, forKey: .msg)
    }
}

typealias DbhEndRideData = DbhEndRideModel

struct DbhEndRideModel : Codable {
    let data : [DbhEndRideDataR]?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([DbhEndRideDataR].self, forKey: .data)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct DbhEndRideDataR : Codable {
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}
