//
//  CancelRideModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 02/10/22.
//

import Foundation

//1 MARK: - Intimate To Partner Start Ride API
typealias CancelRideData = CancelRideModel

struct CancelRideModel : Codable {
     let status : String?
    let message : String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}
