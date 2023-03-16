//
//  EmployeesService.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation
import UIKit

protocol LateNightChauffeursDriverServiceProtocol {
    //MARK: Login
    func getLoginedUserDetails(_ perams :Dictionary<String,String>, completion: @escaping (_ success: Bool, _ results: UserData?, _ error: String?) -> ())
    //MARK: Forgot Password
    func requestForForgotPasswordServices(_ perams: Dictionary<String,String>, completion: @escaping (_ success: Bool, _ results: ForgotPasswordUserData?, _ error: String?) -> ())
    //MARK: Registration
    func requestForRegistrationServices(_ perams: Dictionary<String, String>,peramsModel:registartionStruct, profilepic_name: String, profilepic: UIImage, vehicle_image_name: String, vehicle_image: UIImage, documents_image_name: String, documents_image: UIImage, license_image_name: String, license_image: UIImage, driver_abstract_name: String, driver_abstract: UIImage, completion: @escaping (_ success: Bool, _ results: RegistrationUserData?, _ error: String?) -> ())
    //MARK: Logout
    func requestForLogoutServices(_ perams: Dictionary<String,String>, completion: @escaping (_ success: Bool, _ results: SideMenuUserData?, _ error: String?) -> ())
    //MARK: Delete Account
    func requestForDeleteAccountServices(_ perams: Dictionary<String,String>, completion: @escaping (_ success: Bool, _ results: SideMenuUserData?, _ error: String?) -> ())
    //MARK: Contact US
    func requestForContactUsServices(_ perams: Dictionary<String,String>,  completion: @escaping (_ success: Bool, _ results: ContactUsUserData?, _ error: String?) -> ())
    //MARK: Change Password
    func requestForChangePasswordServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: ChangePasswordUserData?, _ error: String?) -> ())
    //MARK: Edit Profile
    func requestForEditProfileServices(_ perams: Dictionary<String, String>,picImage: UIImage,fileName: String, profileStruct : uploadImage, completion: @escaping (_ success: Bool, _ results: ProfileUserData?, _ error: String?) -> ())
    //MARK: - Add Bank Details
    func requestForAddBankDetailsServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: AddBankDetailsUserData?, _ error: String?) -> ())
    //MARK: - GET Bank Details
    func requestForGetBankDetailsServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: GetBankDetailsData?, _ error: String?) -> ())
    //MARK: - GET Vehicle Details
    func requestForGetVehicleDetailsServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: GetVehicleData?, _ error: String?) -> ())
    //MARK: - Post Edit Vehicle Details
   // func requestForEditVehicleDetailsService(_ perams: Dictionary<String, String>,vehicle_image_name: String, vehicle_image: UIImage,documents_image_name: String, documents_image: UIImage,license_image_name: String, license_image: UIImage,driver_abstract_name: String, driver_abstract: UIImage, completion: @escaping (_ success: Bool, _ results: EditVehicleDataModel2?, _ error: String?) -> ())
    
    //MARK: - Get Emplyee Guidelines PDF Url
    func requestForGetEmplyeeGuidelinesServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: TermsPrivacyData?, _ error: String?) -> ())
    //MARK: - weeklu Payments list
    func requestForGetWeeklyPaymentslistServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: WeeklyPaymentsWeekData?, _ error: String?) -> ())
    func requestForGetWeeklyPaymentsInfolistServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: WeekRideinfoData?, _ error: String?) -> ())
    
    //MARK: - Payment history
    func requestForPaymentHistoryServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: PaymentHistoryData?, _ error: String?) -> ())
    
    //MARK: - Ride History
    func requestForRideHistoryServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: RideHistoryViewData?, _ error: String?) -> ())
    
    //MARK: - Activate Reward
    func requestForActivateRewardServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: ActivateRewardProgramData?, _ error: String?) -> ())
    
    //MARK: - Avilable Reward
    func requestForAvailableRewardProgramsListServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: AvailableRewardProgramsListData?, _ error: String?) -> ())
    
    //MARK: - Activated Reward Programs
    func requestForActivatedRewardProgramsServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: ActivatedRewardProgramsData?, _ error: String?) -> ())
    
    //MARK: - History Of Reward Programs
    func requestForHistoryOfRewardProgramsServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: HistoryOfRewardProgramsData?, _ error: String?) -> ())
        
    //MARK: - update partner status
    func requestForUpdatePartnerStatusService(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: UpdateManagePartnersData?, _ error: String?) -> ())
    
    //MARK: - get partner list
    func requestForManagePartnersServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: ManagePartnersData?, _ error: String?) -> ())
    
    //MARK: - Add Manager Partner
    func requestForAddManagePartnersServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: AddManagePartnersData?, _ error: String?) -> ())

    //MARK: - ActivePartnerAPI
    func requestForActivePartnerAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: DriverTypeData?, _ error: String?) -> ())
    
    //MARK: -  selectDriverTypeAPI
    func requestForSelectDriverTypeAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: AddNewPartnerListData?, _ error: String?) -> ())
    
    //MARK: - LookingForPartnerAPI
    func requestForLookingForPartnerAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: UpdateManagePartnersData?, _ error: String?) -> ())
    
    //MRK:- PartnerListAPI
    func requestForPartnerListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: PartnerListData?, _ error: String?) -> ())
    
    //MRK:- Dummy Partner selectDriverTypeAPI
    func requestForDummyPartnerSelectForFutureServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: DriverTypeData?, _ error: String?) -> ())
    
    //MARK: - DBH Assign Ride List
    func requestForDBHAssignRideListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: ListOfAssignRidesData?, _ error: String?) -> ())
    
    //MARK: - DriverfutureRideListAPI
    func requestFordriverfutureRideListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: RideReservationsData?, _ error: String?) -> ())
    
    //MARK: -  PartnerfutureRideListAPI
    func requestForPartnerfutureRideListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: RideReservationsData?, _ error: String?) -> ())
    
    //MARK: - DriverAcceptfutureRideAPI
    func requestdriverAcceptFutureRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: AcceptedRideReservationsData?, _ error: String?) -> ())
    
    //MARK: - partnerAcceptfutureRideAPI
    func requestForPartnerAcceptFutureRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: AcceptedRideReservationsData?, _ error: String?) -> ())
    
    //MARK: - Aleready Accepted ride time bases --showing accepted button as partner
    //MARK: - PartnerfutureRideAccepetedListAPI
    func requestForpartnerAcceptedFutureRideAcceptedListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: AlereadyAcceptedridetimebasesData?, _ error: String?) -> ())

    //MARK: - Aleready Accepted ride time bases --showing accepted button as Driver
    //MARK: - DriverfutureRideAccepetedListAPI
    //MARK: - DriverfutureRideListAPI
    func requestFordriverfutureRideListAcceptedAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: AlereadyAcceptedridetimebasesData?, _ error: String?) -> ())
    
    //MARK: - Accepted Rides -- DriverOnlineAPI
    func requestForDriverOnlineAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: CancelRideData?, _ error: String?) -> ())
    
    //MARK: - Accepted Rides -- DriverRoleChangeAPI
    func requestForDriverRoleChangeAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: RideReservationsData?, _ error: String?) -> ())

    //MARK: - Accepted Rides -- DriverfutureRideListAPI
    func requestForDriverAcceptedFutureRideListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: RideReservationsData?, _ error: String?) -> ())
    
    //MARK: - Accepted Rides -- PartnerfutureRideListAPI
    func requestForpartnerAcceptedFutureRideListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: RideReservationsData?, _ error: String?) -> ())
    
    //MARK: - Ongoing Ride Details --- driverAdditionalStopsAPIwithDriverID
    func requestFordriverAdditionalStopsAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: driverAdditionalStopsData?, _ error: String?) -> ())
    
    //MARK: - Ongoing Ride Details ---- WaitingChargesStartAPI
    func requestForWaitingChargesStartAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: WaitingChargesStartData?, _ error: String?) -> ())

    //MARK: - Ongoing Ride Details --- driverwaiting time APIwithDriverID
    func requestForDriverWaitingTimeAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: driverWaitingTimeData?, _ error: String?) -> ())

    //MARK: - Ongoing Ride Details --- AdditionalStopswaitingtime
    func requestForAdditionalStopswaitingtimeAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: AdditionalStopswaitingtimeData?, _ error: String?) -> ())
    //MARK: - Ongoing Ride Details --- DriverRideCompleteAPI
    func requestForDriverRideCompleteAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: DriverRideCompleteData?, _ error: String?) -> ())
    
    //MARK: - Ongoing Ride Details --- DriverRideStartAPI
    func requestForDriverRideStartAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: DriverRideStartData?, _ error: String?) -> ())

    //MARK: - Ongoing Ride Details --- DriverFutureRideDetailsAPI
    func requestForDriverFutureRideDetailsAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: DriverFutureRideDetailsData?, _ error: String?) -> ())
    
    //MARK: - Ongoing Ride Details --- PartnerFutureRideDetailsAPI
    func requestForPartnerFutureRideDetailsAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: PartnerFutureRideDetailsData?, _ error: String?) -> ())
    
    //MARK: - Ongoing Ride Details --- DriverRidePaymentAPI
    func requestForDriverRidePaymentAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: DriverRidePaymentData?, _ error: String?) -> ())
    
    //MARK: -  Ongoing Ride Details --- IntimateToPartnerStartRideAPI
    func requestForIntimateToPartnerStartRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: IntimateToPartnerStartRideData?, _ error: String?) -> ())
    
    //MARK: - Ongoing Ride Details --- DriverUpdateCurrentLocationAPI
    func requestForDriverUpdateCurrentLocationAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: DriverUpdateCurrentLocationData?, _ error: String?) -> ())
    
    //MARK: - Cancel Ride -- DriverFutureCancelRideAPI
    func requestForDriverFutureCancelRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: CancelRideData?, _ error: String?) -> ())
    //MARK: - Cancel Ride -- PartnerFutureCancelRideAPI
    func requestForPartnerFutureCancelRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: CancelRideData?, _ error: String?) -> ())
    //MARK: - Cancel Ride -- DriverCurrentCancelRideAPI
    func requestForDriverCurrentCancelRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: CancelRideData?, _ error: String?) -> ())
    
    //MARK: - Cancel Ride -- PartnerCurrentCancelRideAPI
    func requestForPartnerCurrentCancelRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: CancelRideData?, _ error: String?) -> ())
    
    //MARK: - Chat -- DriverToUserChattingAPI
    func requestForDriverToUserChattingAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: ChatData?, _ error: String?) -> ())

    //MARK: - Chat -- DriverToPartnerChattingAPI
    func requestForDriverToPartnerChattingAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: ChatData?, _ error: String?) -> ())
    
    //MARK: - Chat -- PARTNERTOCHATWITHDRIVERApi
    func requestForPartnerToChatWithDriverAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: ChatData?, _ error: String?) -> ())

    //MARK: - Chat -- driverCurrentRideDetailsAPI
    func requestForDriverCurrentRideDetailsAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: ChatDetailsData?, _ error: String?) -> ())
    
    //MARK: - Chat -- partnerCurrentRideDetailsAPI
    func requestForPartnerCurrentRideDetailsAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: ChatDetailsData?, _ error: String?) -> ())
    
    //MARK: - RidePreview -- DriverCurrentRideCompleteAPI
    func requestForDriverCurrentRideCompleteAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: RideChargesPreviewData?, _ error: String?) -> ())

    //MARK: - RidePreview -- DriverCurrentRidePaymentAPI
    func requestForDriverCurrentRidePaymentAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: RideChargesPreviewData?, _ error: String?) -> ())    
    //MARK: -  RidePreview -- DriverFutureRidePaymentAPI
    func requestForDriverFutureRidePaymentAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: RideChargesPaymentPreviewData?, _ error: String?) -> ())
    //MARK: -  RidePreview -- DriverFutureRideCompleteAPI
    func requestForDriverFutureRideCompleteAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: RideChargesPreviewData?, _ error: String?) -> ())
    //MARK: - FeedBack Seen
    func requestForFeedbackAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (_ success: Bool, _ results: FeedBacData?, _ error: String?) -> ())

    //MARK: - Notification List
    func requestForNotificationServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, NotificationData?, String?) -> ())
    //MARK: - get next ride time
    func requestForNextRIDETimeAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DashBoardDriverUpdateModel?, String?) -> ())
    //MARK: - get Google key
    func requestForgetgooglekeyListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DashBoardUserData?, String?) -> ())

}

//MARK: - Login
class ApiService: LateNightChauffeursDriverServiceProtocol {
        
    func getLoginedUserDetails(_ perams :Dictionary<String,String>, completion: @escaping (Bool, UserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_LOGIN_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(UserData.self, from: data!)
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

//MARK: - Forgot Password
extension ApiService {
    func requestForForgotPasswordServices(_ perams :Dictionary<String,String>, completion: @escaping (Bool, ForgotPasswordUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_FORGETPASSWORD_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ForgotPasswordUserData.self, from: data!)
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

//MARK: - Registration
extension ApiService {
    func requestForRegistrationServices(_ perams: Dictionary<String, String>,peramsModel:registartionStruct, profilepic_name: String, profilepic: UIImage,vehicle_image_name: String, vehicle_image: UIImage,documents_image_name: String, documents_image: UIImage,license_image_name: String, license_image: UIImage,driver_abstract_name: String, driver_abstract: UIImage, completion: @escaping (Bool, RegistrationUserData?, String?) -> ()) {
        
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        
        HttpRequestHelper().uploadImagePOSTForRegistartion(url: API_URl.API_REGISTRATION_URL, params: perams,peramsModel:peramsModel, profilepic_name: profilepic_name, profilepic: profilepic,vehicle_image_name: vehicle_image_name, vehicle_image: vehicle_image,documents_image_name: documents_image_name, documents_image: documents_image,license_image_name: license_image_name, license_image: license_image,driver_abstract_name: driver_abstract_name, driver_abstract: driver_abstract, httpHeader: .application_x_www_form_urlencoded) { success, model in
            if success {
                do {
                    //let model = try JSONDecoder().decode(RegistrationUserData.self, from: data!)
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

//MARK: - Logout
extension ApiService {
    func requestForLogoutServices(_ perams :Dictionary<String,String>, completion: @escaping (Bool, SideMenuUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        //        HttpRequestHelper().GET(url: API_URl.API_LOGOUT_URL, params: perams, httpHeader: .application_json) { success, data in
        //            if success {
        //                do {
        //                    let model = try JSONDecoder().decode(SideMenuUserData.self, from: data!)
        //                    completion(true, model, nil)
        //                } catch {
        //                    completion(false, nil, I18n.ModelDecodeErrorString)
        //                }
        //            } else {
        //                completion(false, nil, I18n.GetRequestFailedString)
        //            }
        //        }
    }
}

//MARK: - Contact US
extension ApiService {
    func requestForContactUsServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, ContactUsUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_CONTACTUS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ContactUsUserData.self, from: data!)
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

//MARK: - Change Password
extension ApiService {
    func requestForChangePasswordServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, ChangePasswordUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_CHANGEPASSWORD_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ChangePasswordUserData.self, from: data!)
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

//MARK: - Edit Profile
extension ApiService {
    func requestForEditProfileServices(_ perams: Dictionary<String, String>,picImage: UIImage,fileName: String, profileStruct : uploadImage, completion: @escaping (Bool, ProfileUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        
        HttpRequestHelper().uploadImagePOST(url: API_URl.API_UPDATEPROFILE_URL, params: perams, fileName: fileName, picImage: picImage,httpHeader: .application_json, profileStruct : profileStruct) { success, data in
            if success {
                do {
                    //let model = try JSONDecoder().decode(ProfileUserData.self, from: data!)
                    completion(true, data, nil)
                } catch {
                    completion(false, nil, I18n.ModelDecodeErrorString)
                }
            } else {
                completion(false, nil, I18n.GetRequestFailedString)
            }
        }
    }
}

//MARK: - Add Bank Details
extension ApiService  {
    
    func requestForAddBankDetailsServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, AddBankDetailsUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_ADDBANKACCOUNTDETAILS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(AddBankDetailsUserData.self, from: data!)
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

//MARK: - Get Bank Details
extension ApiService  {
    
    func requestForGetBankDetailsServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, GetBankDetailsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_BANKACCOUNTDETAILS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(GetBankDetailsData.self, from: data!)
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

//MARK: - GET Vehicle Details
extension ApiService {
    func requestForGetVehicleDetailsServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, GetVehicleData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_VEHICLEINFO_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(GetVehicleData.self, from: data!)
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

//MARK: - Edit Profile Data
//extension ApiService {
//
//    func requestForEditVehicleDetailsService(_ perams: Dictionary<String, String>, vehicle_image_name: String, vehicle_image: UIImage, documents_image_name: String, documents_image: UIImage, license_image_name: String, license_image: UIImage, driver_abstract_name: String, driver_abstract: UIImage, completion: @escaping (Bool, EditVehicleDataModel2?, String?) -> ()) {
//        if Connectivity.isNotConnectedToInternet{
//            completion(false, nil, I18n.NoInterNetString)
//        }
//
//
//
//        HttpRequestHelper().uploadEditVehicleImagePOST(url: API_URl.API_EDITVEHICLEINFO_URL, params: perams, vehicle_image_name: vehicle_image_name, vehicle_image: vehicle_image, documents_image_name: documents_image_name, documents_image: documents_image, license_image_name: license_image_name, license_image: license_image, driver_abstract_name: driver_abstract_name, driver_abstract: driver_abstract, httpHeader: .application_x_www_form_urlencoded) { success, data in
//            if success {
//                do {
//                   // let model = try JSONDecoder().decode(EditVehicleData.self, from: data!)
//                    completion(true, data, nil)
//                } catch {
//                    completion(false, nil, I18n.ModelDecodeErrorString)
//                }
//            } else {
//                completion(false, nil, I18n.GetRequestFailedString)
//            }
//        }
//    }
//}
//MARK: - Get Emplyee Guidelines PDF Url
extension ApiService {
    func requestForGetEmplyeeGuidelinesServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, TermsPrivacyData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_Handbookbase_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(TermsPrivacyData.self, from: data!)
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

//MARK: - weekly Payments list
extension ApiService {
    func requestForGetWeeklyPaymentslistServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, WeeklyPaymentsWeekData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_WEEKLY_PAYMENTS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(WeeklyPaymentsWeekData.self, from: data!)
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
//MARK: - weekly Payments list
extension ApiService {
    func requestForGetWeeklyPaymentsInfolistServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, WeekRideinfoData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_WeeklyRideinfo_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(WeekRideinfoData.self, from: data!)
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
//MARK: - Payment history
extension ApiService {
    func requestForPaymentHistoryServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, PaymentHistoryData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERRIDEPAYMENTHISTORYLIST_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(PaymentHistoryData.self, from: data!)
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
//MARK: - Ride History
extension ApiService {
    func requestForRideHistoryServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, RideHistoryViewData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERRIDEHISTORYLIST_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(RideHistoryViewData.self, from: data!)
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

//MARK: - Avilable Reward
extension ApiService {
    func requestForAvailableRewardProgramsListServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, AvailableRewardProgramsListData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_AVAILABLE_REWARD_PROG_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(AvailableRewardProgramsListData.self, from: data!)
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
//MARK: - Activate Reward
extension ApiService {
    func requestForActivateRewardServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, ActivateRewardProgramData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_ACTIVATE_REWARD_PROG_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ActivateRewardProgramData.self, from: data!)
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
//MARK: - Activated Reward Programs
extension ApiService {
    func requestForActivatedRewardProgramsServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, ActivatedRewardProgramsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_MY_REWARDS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ActivatedRewardProgramsData.self, from: data!)
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
//MARK: - History Of Reward Programs
extension ApiService {
    func requestForHistoryOfRewardProgramsServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, HistoryOfRewardProgramsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_HISTORY_REWARDS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(HistoryOfRewardProgramsData.self, from: data!)
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
//MARK: - update partner status
extension ApiService {
    func requestForUpdatePartnerStatusService(_ perams: Dictionary<String, String>, completion: @escaping (Bool, UpdateManagePartnersData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_UPDATE_PARTNER_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(UpdateManagePartnersData.self, from: data!)
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

//MARK: - get partner list
extension ApiService {
    func requestForManagePartnersServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, ManagePartnersData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_MANAGEPARTNERS_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ManagePartnersData.self, from: data!)
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
//MARK: - Add Manager Partner
extension ApiService {
    func requestForAddManagePartnersServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, AddManagePartnersData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_ADDPARTNER_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(AddManagePartnersData.self, from: data!)
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
//MARK: - ActivePartnerAPI
extension ApiService {
    func requestForActivePartnerAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DriverTypeData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_ACTIVATEPARTNER_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(DriverTypeData.self, from: data!)
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
//MARK: -  selectDriverTypeAPI
extension ApiService {
    func requestForSelectDriverTypeAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, AddNewPartnerListData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_SELECTPARTNERTYPE_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(AddNewPartnerListData.self, from: data!)
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
//MARK: - LookingForPartnerAPI
extension ApiService {
    func requestForLookingForPartnerAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, UpdateManagePartnersData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERREQUESTTOPARTNER_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(UpdateManagePartnersData.self, from: data!)
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
//MRK:- PartnerListAPI
extension ApiService {
    func requestForPartnerListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, PartnerListData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_PARTNERLIST_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(PartnerListData.self, from: data!)
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
//MRK:- Dummy Partner selectDriverTypeAPI
extension ApiService {
    func requestForDummyPartnerSelectForFutureServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DriverTypeData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_SELECTDUMMYPARTNERTYPEFORFUTURE_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(DriverTypeData.self, from: data!)
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

//MARK: - DBH Assign Ride List
extension ApiService {
    func requestForDBHAssignRideListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, ListOfAssignRidesData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DBH_ASSIGN_RIDES_LIST_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ListOfAssignRidesData.self, from: data!)
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

//MARK: - DriverfutureRideListAPI
extension ApiService {
    func requestFordriverfutureRideListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, RideReservationsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERFUTURERIDELIST_URL, params: perams, httpHeader: .application_json) { success, data in
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
//MARK: -  PartnerfutureRideListAPI
extension ApiService {
    func requestForPartnerfutureRideListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, RideReservationsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_PARTNERFUTURERIDELIST_URL, params: perams, httpHeader: .application_json) { success, data in
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
//MARK: - DriverAcceptfutureRideAPI
extension ApiService {
    func requestdriverAcceptFutureRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, AcceptedRideReservationsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERACCEPTFUTURERIDE_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(AcceptedRideReservationsData.self, from: data!)
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
//MARK: - partnerAcceptfutureRideAPI
extension ApiService {
    func requestForPartnerAcceptFutureRideAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, AcceptedRideReservationsData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_PARTNERACCEPTFUTURERIDE_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(AcceptedRideReservationsData.self, from: data!)
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
//MARK: - Aleready Accepted ride time bases --showing accepted button as partner
//MARK: - PartnerfutureRideAccepetedListAPI
extension ApiService {
    func requestForpartnerAcceptedFutureRideAcceptedListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, AlereadyAcceptedridetimebasesData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_PARTNERACCEPTEDFUTURERIDELIST_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(AlereadyAcceptedridetimebasesData.self, from: data!)
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
//MARK: - Aleready Accepted ride time bases --showing accepted button as Driver
//MARK: - DriverfutureRideAccepetedListAPI
//MARK: - DriverfutureRideListAPI
extension ApiService {
    func requestFordriverfutureRideListAcceptedAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, AlereadyAcceptedridetimebasesData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, "I18n.NoInterNetString")
        }
        HttpRequestHelper().GET(url: API_URl.API_DRIVERACCEPTEDFUTURERIDELIST_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(AlereadyAcceptedridetimebasesData.self, from: data!)
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
    //MARK: - Notification List
    func requestForNotificationServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, NotificationData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_RichNotification_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(NotificationData.self, from: data!)
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
    //MARK: - get next ride time
    func requestForNextRIDETimeAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DashBoardDriverUpdateModel?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_UPDATE_DRIVER_INFO_VIA_DASHBOARD_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(DashBoardDriverUpdateModel.self, from: data!)
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
//MARK: - get Google key
extension ApiService {
     func requestForgetgooglekeyListAPIServices(_ perams: Dictionary<String, String>, completion: @escaping (Bool, DashBoardUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.Api_GET_GOOLE_KEY, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(DashBoardUserData.self, from: data!)
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
//MARK: - Delete Account
extension ApiService {
    func requestForDeleteAccountServices(_ perams :Dictionary<String,String>, completion: @escaping (Bool, SideMenuUserData?, String?) -> ()) {
        if Connectivity.isNotConnectedToInternet{
            completion(false, nil, I18n.NoInterNetString)
        }
        HttpRequestHelper().GET(url: API_URl.API_DELETEACCOUNT_URL, params: perams, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(SideMenuUserData.self, from: data!)
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
