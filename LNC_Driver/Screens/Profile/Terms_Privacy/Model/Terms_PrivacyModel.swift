//
//  Terms_PrivacyModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import Foundation

typealias TermsPrivacyData = Terms_PrivacyModel

struct Terms_PrivacyModel : Codable {
    let pdf_name : String?
    let loginStatus : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case pdf_name = "pdf_name"
        case loginStatus = "status"
        case message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pdf_name = try values.decodeIfPresent(String.self, forKey: .pdf_name)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}
