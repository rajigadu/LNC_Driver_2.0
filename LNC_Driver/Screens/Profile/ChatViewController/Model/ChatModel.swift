//
//  ChatModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 02/10/22.
//

import Foundation

typealias ChatData = ChatModel

struct ChatModel : Codable {
    let data : [ChatDatar]?
    let status : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([ChatDatar].self, forKey: .data)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
struct ChatDatar : Codable {
    let profileImageReciever : String?
    let profileImageSender : String?
    let mesage : String?
    let date : String?
    let sender : String?
    let reciever : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case profileImageReciever = "profileImageReciever"
        case profileImageSender = "profileImageSender"
        case mesage = "mesage"
        case date = "date"
        case sender = "sender"
        case reciever = "reciever"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profileImageReciever = try values.decodeIfPresent(String.self, forKey: .profileImageReciever)
        profileImageSender = try values.decodeIfPresent(String.self, forKey: .profileImageSender)
        mesage = try values.decodeIfPresent(String.self, forKey: .mesage)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        sender = try values.decodeIfPresent(String.self, forKey: .sender)
        reciever = try values.decodeIfPresent(String.self, forKey: .reciever)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}


typealias ChatDetailsData = ChatDetailsModel

struct ChatDetailsModel : Codable {
    let data : [ChatDetailsDatar]?
    let status : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([ChatDetailsDatar].self, forKey: .data)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
struct ChatDetailsDatar : Codable {
    let userid : String?
    enum CodingKeys: String, CodingKey {

        case userid = "userid"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userid = try values.decodeIfPresent(String.self, forKey: .userid)
    }

}
