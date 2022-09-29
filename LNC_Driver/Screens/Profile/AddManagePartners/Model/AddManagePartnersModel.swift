//
//  AddManagePartnersModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import Foundation
typealias AddManagePartnersData = AddManagePartnersModel
struct AddManagePartnersModel : Codable {
    let message : String?
    let status : String?
 
    enum CodingKeys: String, CodingKey {

        case message = "msg"
        case status = "status"
     }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
     }

}
