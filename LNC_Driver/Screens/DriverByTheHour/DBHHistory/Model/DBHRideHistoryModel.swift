//
//  DBHRideHistoryModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 19/03/23.
//

import Foundation

typealias DBHRideHistoryData = DBHRideHistoryModel

struct DBHRideHistoryModel : Codable {
   // let message : String?
    let status : String?
    let data : [DBHRideHistoryDatar]?
    let message : String?

    enum CodingKeys: String, CodingKey {

      //  case message = "message"
        case status = "status"
        case data = "data"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       // message = try values.decodeIfPresent(String.self, forKey: .message)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent([DBHRideHistoryDatar].self, forKey: .data)
    }

}

    struct DBHRideHistoryDatar : Codable {
        let id : String?
        let user_id : String?
        let card_id : String?
        let time : String?
        let date : String?
        let otherdate : String?
        let booking_type : String?
        let pickup_address : String?
        let pickup_lat : String?
        let pickup_long : String?
        let city_pickup : String?
        let city_pickup2 : String?
        let notes : String?
        let status : String?
        let driver_status : String?
        let driver_id_for_future_ride : String?
        let future_accept : String?
        let ride_assign_status : String?
        let ride_start_time : String?
        let ride_end_time : String?
        let cancel_status : String?
        let cancel_time : String?
        let ride_cancel_by : String?
        let future_ride_start : String?
        let promo : String?
        let tip_status : String?
        let admin_charge : String?
        let reason : String?
        let second : String?
        let acctid : String?
        let platform : String?
        let extra_charges : String?
        let end_date : String?
        let end_time : String?
        let ride_total_time : String?
        let ride_total_minute : String?
        let hourly_rate_while_ride_completed : String?
        let car_transmission : String?
        let feedback_status : String?
        let created_at : String?
        let first_name : String?
        let last_name : String?

        enum CodingKeys: String, CodingKey {

            case id = "id"
            case user_id = "user_id"
            case card_id = "card_id"
            case time = "time"
            case date = "date"
            case otherdate = "otherdate"
            case booking_type = "booking_type"
            case pickup_address = "pickup_address"
            case pickup_lat = "pickup_lat"
            case pickup_long = "pickup_long"
            case city_pickup = "city_pickup"
            case city_pickup2 = "city_pickup2"
            case notes = "notes"
            case status = "status"
            case driver_status = "driver_status"
            case driver_id_for_future_ride = "driver_id_for_future_ride"
            case future_accept = "future_accept"
            case ride_assign_status = "ride_assign_status"
            case ride_start_time = "ride_start_time"
            case ride_end_time = "ride_end_time"
            case cancel_status = "cancel_status"
            case cancel_time = "cancel_time"
            case ride_cancel_by = "ride_cancel_by"
            case future_ride_start = "future_ride_start"
            case promo = "promo"
            case tip_status = "tip_status"
            case admin_charge = "admin_charge"
            case reason = "reason"
            case second = "second"
            case acctid = "acctid"
            case platform = "platform"
            case extra_charges = "extra_charges"
            case end_date = "end_date"
            case end_time = "end_time"
            case ride_total_time = "ride_total_time"
            case ride_total_minute = "ride_total_minute"
            case hourly_rate_while_ride_completed = "hourly_rate_while_ride_completed"
            case car_transmission = "car_transmission"
            case feedback_status = "feedback_status"
            case created_at = "created_at"
            case first_name = "first_name"
            case last_name = "last_name"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(String.self, forKey: .id)
            user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
            card_id = try values.decodeIfPresent(String.self, forKey: .card_id)
            time = try values.decodeIfPresent(String.self, forKey: .time)
            date = try values.decodeIfPresent(String.self, forKey: .date)
            otherdate = try values.decodeIfPresent(String.self, forKey: .otherdate)
            booking_type = try values.decodeIfPresent(String.self, forKey: .booking_type)
            pickup_address = try values.decodeIfPresent(String.self, forKey: .pickup_address)
            pickup_lat = try values.decodeIfPresent(String.self, forKey: .pickup_lat)
            pickup_long = try values.decodeIfPresent(String.self, forKey: .pickup_long)
            city_pickup = try values.decodeIfPresent(String.self, forKey: .city_pickup)
            city_pickup2 = try values.decodeIfPresent(String.self, forKey: .city_pickup2)
            notes = try values.decodeIfPresent(String.self, forKey: .notes)
            status = try values.decodeIfPresent(String.self, forKey: .status)
            driver_status = try values.decodeIfPresent(String.self, forKey: .driver_status)
            driver_id_for_future_ride = try values.decodeIfPresent(String.self, forKey: .driver_id_for_future_ride)
            future_accept = try values.decodeIfPresent(String.self, forKey: .future_accept)
            ride_assign_status = try values.decodeIfPresent(String.self, forKey: .ride_assign_status)
            ride_start_time = try values.decodeIfPresent(String.self, forKey: .ride_start_time)
            ride_end_time = try values.decodeIfPresent(String.self, forKey: .ride_end_time)
            cancel_status = try values.decodeIfPresent(String.self, forKey: .cancel_status)
            cancel_time = try values.decodeIfPresent(String.self, forKey: .cancel_time)
            ride_cancel_by = try values.decodeIfPresent(String.self, forKey: .ride_cancel_by)
            future_ride_start = try values.decodeIfPresent(String.self, forKey: .future_ride_start)
            promo = try values.decodeIfPresent(String.self, forKey: .promo)
            tip_status = try values.decodeIfPresent(String.self, forKey: .tip_status)
            admin_charge = try values.decodeIfPresent(String.self, forKey: .admin_charge)
            reason = try values.decodeIfPresent(String.self, forKey: .reason)
            second = try values.decodeIfPresent(String.self, forKey: .second)
            acctid = try values.decodeIfPresent(String.self, forKey: .acctid)
            platform = try values.decodeIfPresent(String.self, forKey: .platform)
            extra_charges = try values.decodeIfPresent(String.self, forKey: .extra_charges)
            end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
            end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
            ride_total_time = try values.decodeIfPresent(String.self, forKey: .ride_total_time)
            ride_total_minute = try values.decodeIfPresent(String.self, forKey: .ride_total_minute)
            hourly_rate_while_ride_completed = try values.decodeIfPresent(String.self, forKey: .hourly_rate_while_ride_completed)
            car_transmission = try values.decodeIfPresent(String.self, forKey: .car_transmission)
            feedback_status = try values.decodeIfPresent(String.self, forKey: .feedback_status)
            created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
            first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
            last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        }

    }
