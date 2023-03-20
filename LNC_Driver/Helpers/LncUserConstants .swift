//
//  LncUserConstants .swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation

let kApptitle = "Late Night Chauffeurs"
class I18n  {

static let NoInterNetString                           = "No Internet,Please Check"
static let SomethingWentWrong                         = "Something went wrong"
    static let NoRecordFound                         = "No records found!"
static let TryAgain                                   = "Please try again after some time!"
static let ModelDecodeErrorString                     = "Error: Trying to parse Employees to model"
static let GetRequestFailedString                     = "Error: Employees GET Request failed"
static let GOOGLE_PLACE_FILTER_KEY                    = "AIzaSyBRzUCMhC0dooTNbHeIpD2iycfIawOHM6g"
static let alertTitle                                 = "LNC Driver"
static let allFieldsEmpty                             = "All fields are mandatory!"
static let registeredEmail                            = "Please Enter your Registered Email!"
static let networkError                               = "There is no internet connection for this device"
static let validEmailID                               = "Enter a valid email id."
static let servernotResponding                        = "Server not responding. Please try again!!"
static let LoginStatus                                = "please login your account?"
static let EnterComments                              = "Please enter your comments"
static let CurrentZipCode                             = "Please enable your Current Zip Code"
static let passwordCheck                              = "password and confirm passowrd not matching"
static let BankAccountNoCheck                         = "ACNumber and ReEnterACNumber not matching"
static let passwordcharacters                         = "password must include 6 Characters"
static let passwordRequiredChar             = "password should be atleast one number and one capital letter"
static let LogoutAlert                                = "Are you sure you want to logout?"
static let completeRide                                = "Are you sure you want to complete the ride?"
static let ServerLoading                              = "Loading..."
static let EmaildPasswordValid                        = "Email & password Should mandatory"
static let EmaildValid                                = "Please Enter Your EmailID"
static let GoogleAPIKey                               = "AIzaSyDac9yBJCmt8Tyry6JJ6GOvNQPx0_j76-o"
static let UploadImage                                = "Please upload image"
static let WithDrawlVadiation                         = "Please Enter lessthan earned Salary"
static let WithDrawlKey                               = "Please Enter your withdrawl Salary"
    static let deleteAccountTitle                         = "Delete Account"
    static let DeleteAccountAlert                         = "Are you sure you want to delete your account? This will permanently erase your account."

}

class API_URl  {

static let API_SERVER_URL                             = "https://lnc.latenightchauffeurs.com/lnc-administrator/ios-test/driver/"//
static let API_IMAGEBASE_URL                          = "https://lnc.latenightchauffeurs.com/lnc-administrator/uploads/"
static let API_LOGIN_URL                              = API_URl.API_SERVER_URL +  "login.php?"
static let API_REGISTRATION_URL                        = API_URl.API_SERVER_URL +  "signup.php"
static let API_FORGETPASSWORD_URL                      = API_URl.API_SERVER_URL +  "forgotpassword.php?"
static let API_CHANGEPASSWORD_URL                      = API_URl.API_SERVER_URL +  "change-password.php?"
static let API_UPDATEPROFILE_URL                       = API_URl.API_SERVER_URL +  "edit-profile-info.php?"
static let API_EDITVEHICLEINFO_URL                     = API_URl.API_SERVER_URL +  "edit-vehicle-info.php"
static let API_VEHICLEINFO_URL                         = API_URl.API_SERVER_URL +  "vehicle-info.php?"
static let API_TERMSCONDITIONS_URL                     = API_URl.API_SERVER_URL +  "terms.php"
static let API_Handbookbase_URL                       = "http://lnc.latenightchauffeurs.com/lnc-administrator/admin/handbook_api.php"
static let API_HELP_URL                                = API_URl.API_SERVER_URL +  "help.php"
static let API_CONTACTUS_URL                           = API_URl.API_SERVER_URL +  "contact-us.php?"
static let API_PRIVACYPOLICY_URL                       = API_URl.API_SERVER_URL +  "privay-policy.php"
static let API_REPORTS_URL                             = API_URl.API_SERVER_URL +  "issue.php?"
static let API_ADDBANKACCOUNTDETAILS_URL               = API_URl.API_SERVER_URL +  "add-bank-detail.php?"
static let API_BANKACCOUNTDETAILS_URL                  = API_URl.API_SERVER_URL +  "get-account-detail.php?"
static let API_CURRENTRIDESTOPLIST_URL                 = API_URl.API_SERVER_URL +  "num-stops-addres-list.php?"
static let API_FEEDBACKTOUSER_URL                      = API_URl.API_SERVER_URL +  "user-rating.php?"
static let API_DBH_FEEDBACKTOUSER_URL                      = API_URl.API_SERVER_URL +  "dbh-user-rating.php?"
static let API_W9FORM_URL                             = "https://lnc.latenightchauffeurs.com/lnc-administrator/admin/lnc-form/index-pay.php"
//DRIVER API'S....
static let API_LOCATIONLIST_URL                         = API_URl.API_SERVER_URL +  "location.php"
static let API_DRIVERRIDEHISTORYLIST_URL                = API_URl.API_SERVER_URL +  "ride-histroy.php?"
    static let API_DRIVER_DBH_RIDE_HISTORY_LIST_URL                = API_URl.API_SERVER_URL +  "dbh-ride-histroy.php?"
static let API_DRIVERRIDEPAYMENTHISTORYLIST_URL         = API_URl.API_SERVER_URL +  "payment-history-complete-cancel.php?"
static let API_DRIVERDERVICETOKEN_URL                   = API_URl.API_SERVER_URL +  "update_device_token.php?"
static let API_DRIVERCURRENTRIDEDETAILS_URL             = API_URl.API_SERVER_URL +  "current-ride.php?"

static let API_DRIVERONLINE_URL                         = API_URl.API_SERVER_URL +  "update-online-status.php?version=yes&"
static let API_DRIVERNextRideTime_URL                         = API_URl.API_SERVER_URL +  "next-ride-time.php?"
static let API_UPDATE_DRIVER_INFO_VIA_DASHBOARD_URL                         = API_URl.API_SERVER_URL +  "home-page-api.php?"
static let API_DriverRoleChangeAPI                          = API_URl.API_SERVER_URL +  "swap-role.php?"
static let API_DRIVERONLINESTATUS_URL                   = API_URl.API_SERVER_URL +  "online-status.php?"
static let API_DRIVERUPDATECURRENTLOCATION_URL          = API_URl.API_SERVER_URL +  "update-driver-location.php?"
static let API_DRIVERACCEPTRIDEREQUEST_URL              = API_URl.API_SERVER_URL +  "driver-response.php?"
static let API_DRIVERRIDECOMPLETE_URL                   = API_URl.API_SERVER_URL +  "ride-complete.php?"
static let API_DRIVERFUTURERIDECOMPLETE_URL             = API_URl.API_SERVER_URL +  "ride-complete-future.php?"
static let API_DRIVERFUTURERIDECANCEL_URL               = API_URl.API_SERVER_URL +  "future-ride-cancel-by-driver.php?"
static let API_PARTNERFUTURERIDECANCEL_URL              = API_URl.API_SERVER_URL +  "future-ride-cancel-by-partner.php?"
static let API_DRIVERCURRENTRIDECANCEL_URL              = API_URl.API_SERVER_URL +  "cancel-ride.php?"
static let API_DRIVER_DBH_RIDE_CANCEL_URL              = API_URl.API_SERVER_URL +  "dbh-cancel-ride.php?"
static let API_PARTNERCURRENTRIDECANCEL_URL             = API_URl.API_SERVER_URL +  "ride-cancel-by-partner.php?"
static let API_DRIVERFUTURERIDEPAYMENT_URL              = API_URl.API_SERVER_URL +  "do-payment-future.php?"// "do-payment-future.php?"//
static let API_DRIVERRIDEPAYMENT_URL                    = API_URl.API_SERVER_URL +  "do-payment.php?"//do-payment-future.php
static let API_HAILEDRIDEFEATURE_URL                    = API_URl.API_SERVER_URL +  "countpeople.php?"
static let API_DRIVER_CHATWITHUSER_URL                  = API_URl.API_SERVER_URL +  "chat.php?"
static let API_DBH_DRIVER_CHATWITHUSER_URL                  = API_URl.API_SERVER_URL +  "dbh-chat.php?"
static let API_DRIVER_CHATWITHPARTNER_URL               = API_URl.API_SERVER_URL +  "driver-chat.php?"
static let API_DRIVERSLIST_URL                          = API_URl.API_SERVER_URL +  "all_drivers.php"
static let API_ALLDRIVERSCHATHISTORY_URL                = API_URl.API_SERVER_URL +  "driver_chat_history.php"
static let API_DRIVERSCHEDULELIST_URL                   = API_URl.API_SERVER_URL +  "schedule_driver_list.php?"
static let API_DRIVERREQUESTTOPARTNER_URL               = API_URl.API_SERVER_URL +  "looking-partner.php?"
static let API_INTIMATETOPARTNERTOSTARTRIDE_URL         = API_URl.API_SERVER_URL +  "notify-partner.php?"
static let API_INTIMATETOPARTNERTOSTARTFUTURERIDE_URL   = API_URl.API_SERVER_URL +  "notify-partner-future.php?"
static let API_DRIVERFUTURERIDELIST_URL                 = API_URl.API_SERVER_URL +  "nearest_available_future_ride.php?"
static let API_DBH_ASSIGN_RIDES_LIST_URL                 = API_URl.API_SERVER_URL +  "dbh-assigned-ride-list.php?"
static let API_DRIVERACCEPTEDFUTURERIDELIST_URL         = API_URl.API_SERVER_URL +  "driver_accepted_future_ride_list.php?"  //driver_accepted_future_ride_list
static let API_DRIVERFUTURERIDEDETAILS_URL              = API_URl.API_SERVER_URL +  "future-ride-detail-driver.php?"
static let API_DRIVERFUTURERIDEHISTORY_URL              = API_URl.API_SERVER_URL +  "future-ride-history-driver.php?"
static let API_DRIVERFUTURERIDESTART_URL                = API_URl.API_SERVER_URL +  "future-ride-start.php?"
static let API_DRIVERCURRENTRIDESTART_URL               = API_URl.API_SERVER_URL +  "current-ride-start.php?"
static let API_DRIVERCURRENTPENDINGRIDELIST_URL         = API_URl.API_SERVER_URL +  "offline-available-rides.php?"
static let API_DRIVERWEEKLYPAYROLL_URL                  = API_URl.API_SERVER_URL +  "drivers-weekly-payroll.php?"
static let API_DRIVERWITHDRAWLSALARY_URL                = API_URl.API_SERVER_URL +  "offline-available-rides.php?"
static let API_WeeklyPaymentHistory_URL                 = API_URl.API_SERVER_URL +  "week-count.php?"  //
static let API_WeeklyRideinfo_URL                       = API_URl.API_SERVER_URL +  "weekly-report.php?" //"weekly-report.php?"
static let API_AdditionalStops_URL                      = API_URl.API_SERVER_URL +  "unplanned-stops.php?"
static let API_WaitingTime_URL                          = API_URl.API_SERVER_URL +  "add-waiting-time.php?"
static let API_AdditionalStopswaitingtime_URL           = API_URl.API_SERVER_URL +  "estimation-price.php?"
static let API_TranyVideos_URL                          = API_URl.API_SERVER_URL +  "training-videos.php?"

//Sandbox
static let API_ACTIVATEPARTNER_URL                     = API_URl.API_SERVER_URL +  "active-partner-new.php?"
static let API_PARTNERLIST_URL                         = API_URl.API_SERVER_URL +  "partner-list-new.php?"
static let API_SELECTPARTNERTYPE_URL                   = API_URl.API_SERVER_URL +  "driver-type-new.php?"
static let API_DRIVERACCEPTFUTURERIDE_URL              = API_URl.API_SERVER_URL +  "future-ride-accept_by_driver_new.php?"
static let API_SELECTDUMMYPARTNERTYPEFORFUTURE_URL     = API_URl.API_SERVER_URL +  "dummy-partner-future-accept-new.php?"
static let API_MANAGE_PARTNERLIST_URL                  = API_URl.API_SERVER_URL +  "manage-partner-list.php?"
static let API_UPDATE_PARTNER_URL                      = API_URl.API_SERVER_URL +  "update-partner-status-new.php?"
static let API_MANAGEPARTNERS_URL                      = API_URl.API_SERVER_URL +  "manage-partner-list.php?"
static let API_ADDPARTNER_URL                          = API_URl.API_SERVER_URL +  "add-partner-new.php?"

static let API_WEEKLY_PAYMENTS_URL                     = API_URl.API_SERVER_URL +  "week-count.php?"

static let API_ACTIVEPARTNER_URL                       = API_URl.API_SERVER_URL +  "active-partner.php?"
static let API_PARTNERACCEPTRIDEREQUEST_URL            = API_URl.API_SERVER_URL +  "partner-response.php?"
static let API_PARTNERDETAILSFROMSERVER_URL            = API_URl.API_SERVER_URL +  "partner-detail.php?"
static let API_PARTNER_CHATWITHDRIVER_URL              = API_URl.API_SERVER_URL +  "driver-chat.php?"
static let API_PARTNERFUTURERIDEHISTORY_URL            = API_URl.API_SERVER_URL +  "future-ride-history-partner.php?"
static let API_PARTNERFUTURERIDEDETAILS_URL            = API_URl.API_SERVER_URL +  "future-ride-detail-partner.php?"
static let API_PARTNERACCEPTFUTURERIDE_URL             = API_URl.API_SERVER_URL +  "future-ride-accept_by_partner.php?"
static let API_PARTNERACCEPTEDFUTURERIDELIST_URL       = API_URl.API_SERVER_URL +  "partner_accepted_future_ride_list.php?"
static let API_PARTNERFUTURERIDELIST_URL               = API_URl.API_SERVER_URL +  "nearest_available_partner_future_ride.php?"
//static let API_PARTNERFUTURERIDEHISTORY_URL           = "future-ride-history-partner.php?"
static let API_INTIMATETIMEFORFUTURERIDE_URL           = API_URl.API_SERVER_URL +  "calcultae_future_ride.php?"
static let API_WAITINGCHARGESSTART_URL                 = API_URl.API_SERVER_URL +  "waiting-charges-start.php?"

//Reward Program
static let API_AVAILABLE_REWARD_PROG_URL               = API_URl.API_SERVER_URL +  "reward-program-list.php?"
static let API_ACTIVATE_REWARD_PROG_URL                = API_URl.API_SERVER_URL +  "active-reward-program.php?"
static let API_DBH_START_RIDE_URL                = API_URl.API_SERVER_URL +  "dbh-start-ride.php?"
static let API_DBH_END_RIDE_URL                = API_URl.API_SERVER_URL +  "dbh-complete-ride.php?"
static let API_MY_REWARDS_URL                          = API_URl.API_SERVER_URL +  "my-reward-program-list.php?"

static let API_HISTORY_REWARDS_URL                     = API_URl.API_SERVER_URL +  "history-reward-program-list.php?" //STATIC
static let API_RichNotification_URL                   = API_URl.API_SERVER_URL +  "notification-message-list.php?"
static let Api_GET_GOOLE_KEY                           = "https://lnc.latenightchauffeurs.com/lnc-administrator/ios-test/google-api-key.php"
static let  API_DELETEACCOUNT_URL                      = API_URl.API_SERVER_URL + "remove-d-acc.php?"
}
