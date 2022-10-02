//
//  OngoingRideDetailsModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 01/10/22.
//

import Foundation

//1 MARK: - Intimate To Partner Start Ride API
typealias IntimateToPartnerStartRideData = IntimateToPartnerStartRideModel

struct IntimateToPartnerStartRideModel : Codable {
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

//2 MARK: - DriverRidePaymentAPI
typealias DriverRidePaymentData = DriverRidePaymentModel

struct DriverRidePaymentModel : Codable {
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


//3 MARK: - driverAdditionalStopsAPIwithDriverID
typealias driverAdditionalStopsData = driverAdditionalStopsModel

struct driverAdditionalStopsModel : Codable {
     let status : String?
    let message : String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

//4 MARK: - WaitingChargesStartAPI
typealias WaitingChargesStartData = WaitingChargesStartModel

struct WaitingChargesStartModel : Codable {
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
//5 MARK: - driverwaiting time
typealias driverWaitingTimeData = driverWaitingTimeModel

struct driverWaitingTimeModel : Codable {
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

//6 MARK: - AdditionalStopswaitingtime
typealias AdditionalStopswaitingtimeData = AdditionalStopswaitingtimeModel

struct AdditionalStopswaitingtimeModel : Codable {
    
    var ride_fare : String?
    var admin_fee : String?
    var earnings : String?
    var ride_cost : String?
    var waiting_charge : String?
    var unplanned_stops : String?
    var total_cost : String?
    var status : String?
    var message : String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case ride_fare = "ride_fare"
        case admin_fee = "admin_fee"
        case earnings = "earnings"
        case ride_cost = "ride_cost"
        case waiting_charge = "waiting_charge"
        case unplanned_stops = "unplanned_stops"
        case total_cost = "total_cost"
        case message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        ride_fare = try values.decodeIfPresent(String.self, forKey: .ride_fare)
        admin_fee = try values.decodeIfPresent(String.self, forKey: .admin_fee)
        earnings = try values.decodeIfPresent(String.self, forKey: .earnings)
        ride_cost = try values.decodeIfPresent(String.self, forKey: .ride_cost)
        waiting_charge = try values.decodeIfPresent(String.self, forKey: .waiting_charge)
        unplanned_stops = try values.decodeIfPresent(String.self, forKey: .unplanned_stops)
        total_cost = try values.decodeIfPresent(String.self, forKey: .total_cost)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

//7 MARK: - DriverRideCompleteAPI
typealias DriverRideCompleteData = DriverRideCompleteModel

struct DriverRideCompleteModel : Codable {
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

//8 MARK: - DriverRideStartAPI

typealias DriverRideStartData = DriverRideStartModel

struct DriverRideStartModel : Codable {
    
    var ride_fare : String?
    var admin_fee : String?
    var earnings : String?
    var ride_cost : String?
    var waiting_charge : String?
    var unplanned_stops : String?
    var total_cost : String?
    var status : String?
    var message : String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case ride_fare = "ride_fare"
        case admin_fee = "admin_fee"
        case earnings = "earnings"
        case ride_cost = "ride_cost"
        case waiting_charge = "waiting_charge"
        case unplanned_stops = "unplanned_stops"
        case total_cost = "total_cost"
        case message = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        ride_fare = try values.decodeIfPresent(String.self, forKey: .ride_fare)
        admin_fee = try values.decodeIfPresent(String.self, forKey: .admin_fee)
        earnings = try values.decodeIfPresent(String.self, forKey: .earnings)
        ride_cost = try values.decodeIfPresent(String.self, forKey: .ride_cost)
        waiting_charge = try values.decodeIfPresent(String.self, forKey: .waiting_charge)
        unplanned_stops = try values.decodeIfPresent(String.self, forKey: .unplanned_stops)
        total_cost = try values.decodeIfPresent(String.self, forKey: .total_cost)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}


//9 MARK: - DriverFutureRideDetailsAPI
typealias DriverFutureRideDetailsData = DriverFutureRideDetailsModel


struct DriverFutureRideDetailsModel : Codable {
    let ride_cost : String?
    let waiting_charge : String?
    let waiting_start_time : String?
    let waiting_time_difference : String?
    let waiting_status : String?
    let planned_stops : String?
    let planned_address : [DriverFutureRideDetailsPlanned_address]?
    let unplanned_stops : String?
    let total_cost : String?
    let data : DriverFutureRideDetailsDatar?
    let status : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case ride_cost = "ride_cost"
        case waiting_charge = "waiting_charge"
        case waiting_start_time = "waiting_start_time"
        case waiting_time_difference = "waiting_time_difference"
        case waiting_status = "waiting_status"
        case planned_stops = "planned_stops"
        case planned_address = "planned_address"
        case unplanned_stops = "unplanned_stops"
        case total_cost = "total_cost"
        case data = "data"
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ride_cost = try values.decodeIfPresent(String.self, forKey: .ride_cost)
        waiting_charge = try values.decodeIfPresent(String.self, forKey: .waiting_charge)
        waiting_start_time = try values.decodeIfPresent(String.self, forKey: .waiting_start_time)
        waiting_time_difference = try values.decodeIfPresent(String.self, forKey: .waiting_time_difference)
        waiting_status = try values.decodeIfPresent(String.self, forKey: .waiting_status)
        planned_stops = try values.decodeIfPresent(String.self, forKey: .planned_stops)
        planned_address = try values.decodeIfPresent([DriverFutureRideDetailsPlanned_address].self, forKey: .planned_address)
        unplanned_stops = try values.decodeIfPresent(String.self, forKey: .unplanned_stops)
        total_cost = try values.decodeIfPresent(String.self, forKey: .total_cost)
        data = try values.decodeIfPresent(DriverFutureRideDetailsDatar.self, forKey: .data)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

struct DriverFutureRideDetailsDatar : Codable {
    let rideid : String?
    let future_ride_start : String?
    let pickup_address : String?
    let drop_address : String?
    let car_transmission : String?
    let userid : String?
    let userfname : String?
    let userlname : String?
    let useremail : String?
    let usermobile : String?
    let userpic : String?
    let partnerid : String?
    let partnerfname : String?
    let partnerlname : String?
    let partneremail : String?
    let partnermobile : String?

    enum CodingKeys: String, CodingKey {

        case rideid = "rideid"
        case future_ride_start = "future_ride_start"
        case pickup_address = "pickup_address"
        case drop_address = "drop_address"
        case car_transmission = "car_transmission"
        case userid = "userid"
        case userfname = "userfname"
        case userlname = "userlname"
        case useremail = "useremail"
        case usermobile = "usermobile"
        case userpic = "userpic"
        case partnerid = "partnerid"
        case partnerfname = "partnerfname"
        case partnerlname = "partnerlname"
        case partneremail = "partneremail"
        case partnermobile = "partnermobile"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rideid = try values.decodeIfPresent(String.self, forKey: .rideid)
        future_ride_start = try values.decodeIfPresent(String.self, forKey: .future_ride_start)
        pickup_address = try values.decodeIfPresent(String.self, forKey: .pickup_address)
        drop_address = try values.decodeIfPresent(String.self, forKey: .drop_address)
        car_transmission = try values.decodeIfPresent(String.self, forKey: .car_transmission)
        userid = try values.decodeIfPresent(String.self, forKey: .userid)
        userfname = try values.decodeIfPresent(String.self, forKey: .userfname)
        userlname = try values.decodeIfPresent(String.self, forKey: .userlname)
        useremail = try values.decodeIfPresent(String.self, forKey: .useremail)
        usermobile = try values.decodeIfPresent(String.self, forKey: .usermobile)
        userpic = try values.decodeIfPresent(String.self, forKey: .userpic)
        partnerid = try values.decodeIfPresent(String.self, forKey: .partnerid)
        partnerfname = try values.decodeIfPresent(String.self, forKey: .partnerfname)
        partnerlname = try values.decodeIfPresent(String.self, forKey: .partnerlname)
        partneremail = try values.decodeIfPresent(String.self, forKey: .partneremail)
        partnermobile = try values.decodeIfPresent(String.self, forKey: .partnermobile)
    }

}
struct DriverFutureRideDetailsPlanned_address : Codable {
    let id : String?
    let ride_id : String?
    let location : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case ride_id = "ride_id"
        case location = "location"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        ride_id = try values.decodeIfPresent(String.self, forKey: .ride_id)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

//10 MARK: - PartnerFutureRideDetailsAPI
typealias PartnerFutureRideDetailsData = PartnerFutureRideDetailsModel


struct PartnerFutureRideDetailsModel : Codable {
    let data : PartnerFutureRideDetailsDatar?
    let status : String?
    let message: String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(PartnerFutureRideDetailsDatar.self, forKey: .data)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
struct PartnerFutureRideDetailsDatar : Codable {
    let rideid : String?
    let future_ride_start : String?
    let pickup_address : String?
    let drop_address : String?
    let id : String?
    let first_name : String?
    let last_name : String?
    let email : String?
    let mobile : String?
    let profile_pic : String?
    let user_first_name : String?
    let user_last_name : String?
    let user_mobile : String?
    let user_id : String?
    let user_profile_pic : String?
    let pickup_lat : String?
    let pickup_long : String?
    let d_lat : String?
    let d_long : String?
    let planned_stops : String?

    enum CodingKeys: String, CodingKey {

        case rideid = "rideid"
        case future_ride_start = "future_ride_start"
        case pickup_address = "pickup_address"
        case drop_address = "drop_address"
        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case email = "email"
        case mobile = "mobile"
        case profile_pic = "profile_pic"
        case user_first_name = "user_first_name"
        case user_last_name = "user_last_name"
        case user_mobile = "user_mobile"
        case user_id = "user_id"
        case user_profile_pic = "user_profile_pic"
        case pickup_lat = "pickup_lat"
        case pickup_long = "pickup_long"
        case d_lat = "d_lat"
        case d_long = "d_long"
        case planned_stops = "planned_stops"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rideid = try values.decodeIfPresent(String.self, forKey: .rideid)
        future_ride_start = try values.decodeIfPresent(String.self, forKey: .future_ride_start)
        pickup_address = try values.decodeIfPresent(String.self, forKey: .pickup_address)
        drop_address = try values.decodeIfPresent(String.self, forKey: .drop_address)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
        user_first_name = try values.decodeIfPresent(String.self, forKey: .user_first_name)
        user_last_name = try values.decodeIfPresent(String.self, forKey: .user_last_name)
        user_mobile = try values.decodeIfPresent(String.self, forKey: .user_mobile)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        user_profile_pic = try values.decodeIfPresent(String.self, forKey: .user_profile_pic)
        pickup_lat = try values.decodeIfPresent(String.self, forKey: .pickup_lat)
        pickup_long = try values.decodeIfPresent(String.self, forKey: .pickup_long)
        d_lat = try values.decodeIfPresent(String.self, forKey: .d_lat)
        d_long = try values.decodeIfPresent(String.self, forKey: .d_long)
        planned_stops = try values.decodeIfPresent(String.self, forKey: .planned_stops)
    }

}
//12 MARK: - Driver Update Current Location API
typealias DriverUpdateCurrentLocationData = DriverUpdateCurrentLocationModel

struct DriverUpdateCurrentLocationModel : Codable {
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
