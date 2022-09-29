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
