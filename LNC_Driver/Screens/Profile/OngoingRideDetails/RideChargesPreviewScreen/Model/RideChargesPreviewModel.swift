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


typealias FeedBacData = FeedBacModel

struct FeedBacModel : Codable {
    let status : String?
    let message : String?
    let userData : [FeedBacDatar]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "msg"
        case userData = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userData = try values.decodeIfPresent([FeedBacDatar].self, forKey: .userData)
    }

}
struct FeedBacDatar : Codable {
     let message : String?

    enum CodingKeys: String, CodingKey {
         case message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
         message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
//typealias ChatDetailsData = ChatDetailsModel
//
//struct ChatDetailsModel : Codable {
//    let data : [ChatDetailsDatar]?
//    let status : String?
//    let message : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case data = "data"
//        case status = "status"
//        case message = "msg"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        data = try values.decodeIfPresent([ChatDetailsDatar].self, forKey: .data)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        message = try values.decodeIfPresent(String.self, forKey: .message)
//    }
//
//}
//struct ChatDetailsDatar : Codable {
//    let message : String?
//    enum CodingKeys: String, CodingKey {
//
//        case userid = "userid"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        userid = try values.decodeIfPresent(String.self, forKey: .userid)
//    }
//
//}
