//
//  RideChargesPreviewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 02/10/22.
//

import Foundation

typealias RideChargesPreviewData = RideChargesPreviewModel

struct RideChargesPreviewModel : Codable {
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
