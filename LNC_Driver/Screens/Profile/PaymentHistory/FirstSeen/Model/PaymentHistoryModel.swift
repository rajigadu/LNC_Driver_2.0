//
//  PaymentHistoryModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import Foundation

typealias PaymentHistoryData = PaymentHistoryModel

struct PaymentHistoryModel : Codable {
    let data : [PaymentHistoryDatar]?
    let status : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([PaymentHistoryDatar].self, forKey: .data)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

struct PaymentHistoryDatar : Codable {
    let id : String?
    let user_id : String?
    let booking_id : String?
    let transaction_id : String?
    let amount : String?
    let payment_date : String?
    let payment : String?
    let waiting_time : String?
    let waiting_amt : String?
    let unplaned_waiting_amt : String?
    let unplaned_waiting_time : String?
    let planed_stop_amt : String?
    let planed_stop_count : String?
    let promo_amt : String?
    let actual_amount : String?
    let city_charges : String?
    let ride_amt : String?
    let pickup_address : String?
    let drop_address : String?
    let driver_id_for_future_ride : String?
    let future_partner_id : String?
    let booking_type : String?
    let otherdate : String?
    let time : String?
    let first_name : String?
    let last_name : String?
    let unplaned_stop_amt : String?
    let unplaned_stop_count : String?
    let ride_fare : String?
    let admin_fee : String?
    let base_price : String?
    let driver_base_share : String?
    let driver_unplanned_stop_amount : String?
    let driver_planned_stop_amount : String?
    let driver_unplanned_waiting_time : String?
    let driver_share : String?
    let partner_base_share : String?
    let partner_unplanned_stop_amount : String?
    let partner_planned_stop_amount : String?
    let partner_unplanned_waiting_time : String?
    let partner_share : String?
    let driver_status : String?
    let drivers_amount : String?
    let partners_amount : String?
    let total_tip_amount : String?
    let drivers_tip : String?
    let partners_tip : String?
    let partners_details : [PaymentHistoryPartners_details]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case booking_id = "booking_id"
        case transaction_id = "transaction_id"
        case amount = "amount"
        case payment_date = "payment_date"
        case payment = "payment"
        case waiting_time = "waiting_time"
        case waiting_amt = "waiting_amt"
        case unplaned_waiting_amt = "unplaned_waiting_amt"
        case unplaned_waiting_time = "unplaned_waiting_time"
        case planed_stop_amt = "planed_stop_amt"
        case planed_stop_count = "planed_stop_count"
        case promo_amt = "promo_amt"
        case actual_amount = "actual_amount"
        case city_charges = "city_charges"
        case ride_amt = "ride_amt"
        case pickup_address = "pickup_address"
        case drop_address = "drop_address"
        case driver_id_for_future_ride = "driver_id_for_future_ride"
        case future_partner_id = "future_partner_id"
        case booking_type = "booking_type"
        case otherdate = "otherdate"
        case time = "time"
        case first_name = "first_name"
        case last_name = "last_name"
        case unplaned_stop_amt = "unplaned_stop_amt"
        case unplaned_stop_count = "unplaned_stop_count"
        case ride_fare = "ride_fare"
        case admin_fee = "admin_fee"
        case base_price = "base_price"
        case driver_base_share = "driver_base_share"
        case driver_unplanned_stop_amount = "driver_unplanned_stop_amount"
        case driver_planned_stop_amount = "driver_planned_stop_amount"
        case driver_unplanned_waiting_time = "driver_unplanned_waiting_time"
        case driver_share = "driver_share"
        case partner_base_share = "partner_base_share"
        case partner_unplanned_stop_amount = "partner_unplanned_stop_amount"
        case partner_planned_stop_amount = "partner_planned_stop_amount"
        case partner_unplanned_waiting_time = "partner_unplanned_waiting_time"
        case partner_share = "partner_share"
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
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
        transaction_id = try values.decodeIfPresent(String.self, forKey: .transaction_id)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        payment_date = try values.decodeIfPresent(String.self, forKey: .payment_date)
        payment = try values.decodeIfPresent(String.self, forKey: .payment)
        waiting_time = try values.decodeIfPresent(String.self, forKey: .waiting_time)
        waiting_amt = try values.decodeIfPresent(String.self, forKey: .waiting_amt)
        unplaned_waiting_amt = try values.decodeIfPresent(String.self, forKey: .unplaned_waiting_amt)
        unplaned_waiting_time = try values.decodeIfPresent(String.self, forKey: .unplaned_waiting_time)
        planed_stop_amt = try values.decodeIfPresent(String.self, forKey: .planed_stop_amt)
        planed_stop_count = try values.decodeIfPresent(String.self, forKey: .planed_stop_count)
        promo_amt = try values.decodeIfPresent(String.self, forKey: .promo_amt)
        actual_amount = try values.decodeIfPresent(String.self, forKey: .actual_amount)
        city_charges = try values.decodeIfPresent(String.self, forKey: .city_charges)
        ride_amt = try values.decodeIfPresent(String.self, forKey: .ride_amt)
        pickup_address = try values.decodeIfPresent(String.self, forKey: .pickup_address)
        drop_address = try values.decodeIfPresent(String.self, forKey: .drop_address)
        driver_id_for_future_ride = try values.decodeIfPresent(String.self, forKey: .driver_id_for_future_ride)
        future_partner_id = try values.decodeIfPresent(String.self, forKey: .future_partner_id)
        booking_type = try values.decodeIfPresent(String.self, forKey: .booking_type)
        otherdate = try values.decodeIfPresent(String.self, forKey: .otherdate)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        unplaned_stop_amt = try values.decodeIfPresent(String.self, forKey: .unplaned_stop_amt)
        unplaned_stop_count = try values.decodeIfPresent(String.self, forKey: .unplaned_stop_count)
        ride_fare = try values.decodeIfPresent(String.self, forKey: .ride_fare)
        admin_fee = try values.decodeIfPresent(String.self, forKey: .admin_fee)
        base_price = try values.decodeIfPresent(String.self, forKey: .base_price)
        driver_base_share = try values.decodeIfPresent(String.self, forKey: .driver_base_share)
        driver_unplanned_stop_amount = try values.decodeIfPresent(String.self, forKey: .driver_unplanned_stop_amount)
        driver_planned_stop_amount = try values.decodeIfPresent(String.self, forKey: .driver_planned_stop_amount)
        driver_unplanned_waiting_time = try values.decodeIfPresent(String.self, forKey: .driver_unplanned_waiting_time)
        driver_share = try values.decodeIfPresent(String.self, forKey: .driver_share)
        partner_base_share = try values.decodeIfPresent(String.self, forKey: .partner_base_share)
        partner_unplanned_stop_amount = try values.decodeIfPresent(String.self, forKey: .partner_unplanned_stop_amount)
        partner_planned_stop_amount = try values.decodeIfPresent(String.self, forKey: .partner_planned_stop_amount)
        partner_unplanned_waiting_time = try values.decodeIfPresent(String.self, forKey: .partner_unplanned_waiting_time)
        partner_share = try values.decodeIfPresent(String.self, forKey: .partner_share)
        driver_status = try values.decodeIfPresent(String.self, forKey: .driver_status)
        drivers_amount = try values.decodeIfPresent(String.self, forKey: .drivers_amount)
        partners_amount = try values.decodeIfPresent(String.self, forKey: .partners_amount)
        total_tip_amount = try values.decodeIfPresent(String.self, forKey: .total_tip_amount)
        drivers_tip = try values.decodeIfPresent(String.self, forKey: .drivers_tip)
        partners_tip = try values.decodeIfPresent(String.self, forKey: .partners_tip)
        partners_details = try values.decodeIfPresent([PaymentHistoryPartners_details].self, forKey: .partners_details)
    }

}
struct PaymentHistoryPartners_details : Codable {
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
