//
//  EmployeesService2.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 01/10/22.
//

import Foundation
import UIKit

//extension LateNightChauffeursDriverServiceProtocol {
//
//}

//MARK: - DriverOnlineAPI
extension ApiService {
    func requestForDriverOnlineAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, CancelRideData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERONLINE_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(CancelRideData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Accepted Rides -- DriverRoleChangeAPI
extension ApiService {
    func requestForDriverRoleChangeAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, RideReservationsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DriverRoleChangeAPI, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(RideReservationsData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Accepted Rides -- DriverfutureRideListAPI
extension ApiService {
    func requestForDriverAcceptedFutureRideListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, RideReservationsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERACCEPTEDFUTURERIDELIST_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(RideReservationsData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Accepted Rides -- PartnerfutureRideListAPI
extension ApiService {
    func requestForpartnerAcceptedFutureRideListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, RideReservationsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_PARTNERACCEPTEDFUTURERIDELIST_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(RideReservationsData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

//MARK: - Ongoing Ride Details --- driverAdditionalStopsAPIwithDriverID
extension ApiService {
    func requestFordriverAdditionalStopsAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, driverAdditionalStopsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_AdditionalStops_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(driverAdditionalStopsData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Ongoing Ride Details --- WaitingChargesStartAPI
extension ApiService {
    func requestForWaitingChargesStartAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, WaitingChargesStartData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_WAITINGCHARGESSTART_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(WaitingChargesStartData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Ongoing Ride Details --- driverwaiting time APIwithDriverID
extension ApiService {
    func requestForDriverWaitingTimeAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, driverWaitingTimeData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_WaitingTime_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(driverWaitingTimeData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Ongoing Ride Details --- AdditionalStopswaitingtime
extension ApiService {
    func requestForAdditionalStopswaitingtimeAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, AdditionalStopswaitingtimeData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_AdditionalStopswaitingtime_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(AdditionalStopswaitingtimeData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

//MARK: - DriverRideCompleteAPI
//MARK: - Ongoing Ride Details --- DriverRideCompleteAPI
extension ApiService {
    func requestForDriverRideCompleteAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DriverRideCompleteData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERFUTURERIDECOMPLETE_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(DriverRideCompleteData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Ongoing Ride Details --- DriverRideStartAPI
extension ApiService {
    func requestForDriverRideStartAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DriverRideStartData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERFUTURERIDESTART_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(DriverRideStartData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Ongoing Ride Details --- DriverFutureRideDetailsAPI
extension ApiService {
    func requestForDriverFutureRideDetailsAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DriverFutureRideDetailsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERFUTURERIDEDETAILS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(DriverFutureRideDetailsData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Ongoing Ride Details --- PartnerFutureRideDetailsAPI
extension ApiService {
    func requestForPartnerFutureRideDetailsAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, PartnerFutureRideDetailsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_PARTNERFUTURERIDEDETAILS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(PartnerFutureRideDetailsData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Ongoing Ride Details --- DriverRidePaymentAPI
extension ApiService {
    func requestForDriverRidePaymentAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DriverRidePaymentData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERFUTURERIDEPAYMENT_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(DriverRidePaymentData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: -  Ongoing Ride Details --- DriverUpdateCurrentLocationAPI
extension ApiService {
    func requestForDriverUpdateCurrentLocationAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DriverUpdateCurrentLocationData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERUPDATECURRENTLOCATION_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(DriverUpdateCurrentLocationData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
extension ApiService {
    func requestForIntimateToPartnerStartRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, IntimateToPartnerStartRideData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_INTIMATETOPARTNERTOSTARTFUTURERIDE_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(IntimateToPartnerStartRideData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Cancel Ride -- DriverFutureCancelRideAPI
extension ApiService {
    func requestForDriverFutureCancelRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, CancelRideData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERFUTURERIDECANCEL_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(CancelRideData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Cancel Ride -- PartnerFutureCancelRideAPI
extension ApiService {
    func requestForPartnerFutureCancelRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, CancelRideData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_PARTNERFUTURERIDECANCEL_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(CancelRideData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Cancel Ride -- DriverCurrentCancelRideAPI
extension ApiService {
    func requestForDriverCurrentCancelRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, CancelRideData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERCURRENTRIDECANCEL_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(CancelRideData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Cancel Ride -- PartnerCurrentCancelRideAPI
extension ApiService {
    func requestForPartnerCurrentCancelRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, CancelRideData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_PARTNERCURRENTRIDECANCEL_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(CancelRideData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Chat -- DriverToUserChattingAPI
extension ApiService {
    func requestForDriverToUserChattingAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, ChatData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVER_CHATWITHUSER_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ChatData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Chat -- DriverToPartnerChattingAPI
extension ApiService {
    func requestForDriverToPartnerChattingAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, ChatData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVER_CHATWITHPARTNER_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ChatData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: -  Chat -- PARTNERTOCHATWITHDRIVERApi
extension ApiService {
    func requestForPartnerToChatWithDriverAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, ChatData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_PARTNER_CHATWITHDRIVER_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ChatData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Chat -- driverCurrentRideDetailsAPI
extension ApiService {
    func requestForDriverCurrentRideDetailsAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, ChatDetailsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERCURRENTRIDEDETAILS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ChatDetailsData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - Chat -- partnerCurrentRideDetailsAPI
extension ApiService {
    func requestForPartnerCurrentRideDetailsAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, ChatDetailsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERCURRENTRIDEDETAILS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ChatDetailsData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

//MARK: - RidePreview -- DriverCurrentRideCompleteAPI
extension ApiService {
    func requestForDriverCurrentRideCompleteAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, RideChargesPreviewData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERRIDECOMPLETE_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(RideChargesPreviewData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - RidePreview -- DriverCurrentRidePaymentAPI
extension ApiService {
    func requestForDriverCurrentRidePaymentAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, RideChargesPreviewData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERRIDEPAYMENT_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(RideChargesPreviewData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: -  RidePreview -- DriverFutureRidePaymentAPI
extension ApiService {
    func requestForDriverFutureRidePaymentAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, RideChargesPaymentPreviewData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERFUTURERIDEPAYMENT_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(RideChargesPaymentPreviewData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: -  RidePreview -- DriverFutureRideCompleteAPI
extension ApiService {
    func requestForDriverFutureRideCompleteAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, RideChargesPreviewData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERFUTURERIDECOMPLETE_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(RideChargesPreviewData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
//MARK: - FeedBack Seen
extension ApiService {
    func requestForFeedbackAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, FeedBacData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_FEEDBACKTOUSER_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(FeedBacData.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}
