//
//  ForgotPasswordUser.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation

typealias ForgotPasswordUserData = ForgotPasswordUserDetails

struct ForgotPasswordUserDetails : Codable {
    let Message : String?
    let loginStatus : String?

    enum CodingKeys: String, CodingKey {

        case Message = "Message"
        case loginStatus = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Message = try values.decodeIfPresent(String.self, forKey: .Message)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
    }

}
