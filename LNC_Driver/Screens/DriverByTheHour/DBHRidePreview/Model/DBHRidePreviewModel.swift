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

