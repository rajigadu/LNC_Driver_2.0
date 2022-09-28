//
//  WeeklyPaymentsModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import Foundation
typealias WeeklyPaymentsWeekData = WeeklyPaymentsModel

struct WeeklyPaymentsModel : Codable {
    let message : String?
    let status : String?
    let week : [WeeklyPaymentsWeekDatar]?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
        case week = "week"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        week = try values.decodeIfPresent([WeeklyPaymentsWeekDatar].self, forKey: .week)
    }

}


struct WeeklyPaymentsWeekDatar : Codable {
    let driver_id : String?
    let effectiveCreditDate : String?
    let effectiveDebitDate : String?
    let amount : String?
    let from_date : String?
    let to_date : String?

    enum CodingKeys: String, CodingKey {

        case driver_id = "driver_id"
        case effectiveCreditDate = "effectiveCreditDate"
        case effectiveDebitDate = "effectiveDebitDate"
        case amount = "amount"
        case from_date = "from_date"
        case to_date = "to_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        driver_id = try values.decodeIfPresent(String.self, forKey: .driver_id)
        effectiveCreditDate = try values.decodeIfPresent(String.self, forKey: .effectiveCreditDate)
        effectiveDebitDate = try values.decodeIfPresent(String.self, forKey: .effectiveDebitDate)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        from_date = try values.decodeIfPresent(String.self, forKey: .from_date)
        to_date = try values.decodeIfPresent(String.self, forKey: .to_date)
    }

}
