//
//  WeekRideinfoModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import Foundation

typealias WeekRideinfoData = WeekRideinfoModel

struct WeekRideinfoModel : Codable {
    let data : [WeekRideinfoDatar]?
    let status : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([WeekRideinfoDatar].self, forKey: .data)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
struct WeekRideinfoDatar : Codable {
    let id : String?
    let ride_id : String?
    let driver_share : String?
    let partner_share : String?
    let admin_share : String?
    let ride_amount : String?
    let base_price : String?
    let total_ride_amount : String?
    let driver_planned_stop_amount : String?
    let driver_base_share : String?
    let partner_base_share : String?
    let admin_base_share : String?
    let driver_unplanned_stop_amount : String?
    let driver_unplanned_waiting_time : String?
    let partner_planned_stop_amount : String?
    let partner_unplanned_stop_amount : String?
    let partner_unplanned_waiting_time : String?
    let admin_planned_stop_amount : String?
    let admin_unplanned_stop_amount : String?
    let admin_unplanned_waiting_time : String?
    let datecreated : String?
    let pickup_address : String?
    let drop_address : String?
    let driver_id : String?
    let future_partner_id : String?
    let booking_type : String?
    let otherdate : String?
    let time : String?
    let unplanned_stops : String?
    let first_name : String?
    let last_name : String?
    let driver_status : String?
    let drivers_amount : String?
    let partners_amount : String?
    let total_tip_amount : String?
    let drivers_tip : String?
    let partners_tip : String?
    let partners_details : [WeekRideinfoPartners_details]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case ride_id = "ride_id"
        case driver_share = "driver_share"
        case partner_share = "partner_share"
        case admin_share = "admin_share"
        case ride_amount = "ride_amount"
        case base_price = "base_price"
        case total_ride_amount = "total_ride_amount"
        case driver_planned_stop_amount = "driver_planned_stop_amount"
        case driver_base_share = "driver_base_share"
        case partner_base_share = "partner_base_share"
        case admin_base_share = "admin_base_share"
        case driver_unplanned_stop_amount = "driver_unplanned_stop_amount"
        case driver_unplanned_waiting_time = "driver_unplanned_waiting_time"
        case partner_planned_stop_amount = "partner_planned_stop_amount"
        case partner_unplanned_stop_amount = "partner_unplanned_stop_amount"
        case partner_unplanned_waiting_time = "partner_unplanned_waiting_time"
        case admin_planned_stop_amount = "admin_planned_stop_amount"
        case admin_unplanned_stop_amount = "admin_unplanned_stop_amount"
        case admin_unplanned_waiting_time = "admin_unplanned_waiting_time"
        case datecreated = "datecreated"
        case pickup_address = "pickup_address"
        case drop_address = "drop_address"
        case driver_id = "driver_id"
        case future_partner_id = "future_partner_id"
        case booking_type = "booking_type"
        case otherdate = "otherdate"
        case time = "time"
        case unplanned_stops = "unplanned_stops"
        case first_name = "first_name"
        case last_name = "last_name"
        case driver_status = "driver_status"
        case drivers_amount = "drivers_amount"
        case partners_amount = "partners_amount"
        case total_tip_amount = "total_tip_amount"
        case drivers_tip = "drivers_tip"
        case partners_tip = "partners_tip"
        case partners_details = "partners_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        ride_id = try values.decodeIfPresent(String.self, forKey: .ride_id)
        driver_share = try values.decodeIfPresent(String.self, forKey: .driver_share)
        partner_share = try values.decodeIfPresent(String.self, forKey: .partner_share)
        admin_share = try values.decodeIfPresent(String.self, forKey: .admin_share)
        ride_amount = try values.decodeIfPresent(String.self, forKey: .ride_amount)
        base_price = try values.decodeIfPresent(String.self, forKey: .base_price)
        total_ride_amount = try values.decodeIfPresent(String.self, forKey: .total_ride_amount)
        driver_planned_stop_amount = try values.decodeIfPresent(String.self, forKey: .driver_planned_stop_amount)
        driver_base_share = try values.decodeIfPresent(String.self, forKey: .driver_base_share)
        partner_base_share = try values.decodeIfPresent(String.self, forKey: .partner_base_share)
        admin_base_share = try values.decodeIfPresent(String.self, forKey: .admin_base_share)
        driver_unplanned_stop_amount = try values.decodeIfPresent(String.self, forKey: .driver_unplanned_stop_amount)
        driver_unplanned_waiting_time = try values.decodeIfPresent(String.self, forKey: .driver_unplanned_waiting_time)
        partner_planned_stop_amount = try values.decodeIfPresent(String.self, forKey: .partner_planned_stop_amount)
        partner_unplanned_stop_amount = try values.decodeIfPresent(String.self, forKey: .partner_unplanned_stop_amount)
        partner_unplanned_waiting_time = try values.decodeIfPresent(String.self, forKey: .partner_unplanned_waiting_time)
        admin_planned_stop_amount = try values.decodeIfPresent(String.self, forKey: .admin_planned_stop_amount)
        admin_unplanned_stop_amount = try values.decodeIfPresent(String.self, forKey: .admin_unplanned_stop_amount)
        admin_unplanned_waiting_time = try values.decodeIfPresent(String.self, forKey: .admin_unplanned_waiting_time)
        datecreated = try values.decodeIfPresent(String.self, forKey: .datecreated)
        pickup_address = try values.decodeIfPresent(String.self, forKey: .pickup_address)
        drop_address = try values.decodeIfPresent(String.self, forKey: .drop_address)
        driver_id = try values.decodeIfPresent(String.self, forKey: .driver_id)
        future_partner_id = try values.decodeIfPresent(String.self, forKey: .future_partner_id)
        booking_type = try values.decodeIfPresent(String.self, forKey: .booking_type)
        otherdate = try values.decodeIfPresent(String.self, forKey: .otherdate)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        unplanned_stops = try values.decodeIfPresent(String.self, forKey: .unplanned_stops)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        driver_status = try values.decodeIfPresent(String.self, forKey: .driver_status)
        drivers_amount = try values.decodeIfPresent(String.self, forKey: .drivers_amount)
        partners_amount = try values.decodeIfPresent(String.self, forKey: .partners_amount)
        total_tip_amount = try values.decodeIfPresent(String.self, forKey: .total_tip_amount)
        drivers_tip = try values.decodeIfPresent(String.self, forKey: .drivers_tip)
        partners_tip = try values.decodeIfPresent(String.self, forKey: .partners_tip)
        partners_details = try values.decodeIfPresent([WeekRideinfoPartners_details].self, forKey: .partners_details)
    }

}

struct WeekRideinfoPartners_details : Codable {
    let partner_name : String?
    let partner_email : String?
    let partner_phone : String?

    enum CodingKeys: String, CodingKey {

        case partner_name = "partner_name"
        case partner_email = "partner_email"
        case partner_phone = "partner_phone"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        partner_name = try values.decodeIfPresent(String.self, forKey: .partner_name)
        partner_email = try values.decodeIfPresent(String.self, forKey: .partner_email)
        partner_phone = try values.decodeIfPresent(String.self, forKey: .partner_phone)
    }

}
