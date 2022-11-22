//
//  OngoingRideDetailsViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 01/10/22.
//

import UIKit
import CoreLocation

class OngoingRideDetailsViewController: UIViewController {
    
    var str_ComingFrom = ""
    var str_SelectedRideID = ""
    var dict_RideInfo :RideReservationsDatar?
    var str_Dateandtime = ""

    lazy var viewModel = {
        OngoingRideDetailsViewModel()
    }()
    //USER RIDE DETAILS SHOWING......
    @IBOutlet weak var viewUserScrollref: UIScrollView!
    @IBOutlet weak var view_UserDetailsInfoInDriverSideRef: UIView!
    @IBOutlet weak var imageview_UserNameRef: UIImageView!
    @IBOutlet weak var lbl_UserNameRef: UILabel!
    @IBOutlet weak var lbl_UserNumberRef: UILabel!
    @IBOutlet weak var btn_GoToUserStartLocationNavRef: UIButton!
    @IBOutlet weak var btn_StartRideFromDriverRef: UIButton!
    @IBOutlet weak var btn_StartRideLocationNavRef: UIButton!
    @IBOutlet weak var lbl_UserRideInfoRef: UILabel!
    @IBOutlet weak var lbl_ChatPushNotificationStatusFromUserRef: UILabel!
    @IBOutlet weak var lbl_ChatPushNotificationStatusFromPartnerRef: UILabel!
    @IBOutlet weak var btn_IntimatePartnerRef: UIButton!
    @IBOutlet weak var lbl_RideIsStartForPartnerSide: UILabel!
    @IBOutlet weak var manualTransmission_Lblref: UILabel!
    
    // waiting time section
    @IBOutlet weak var start_timelblRef: UILabel!
    @IBOutlet weak var NormalTimeRef: UILabel!
    @IBOutlet weak var Startreflblref: UILabel!
    @IBOutlet weak var btn_waitingtimeRef: UIButton!
    @IBOutlet weak var timershowview_ref: UIView!
    
    //AdditionalstopsRef
    @IBOutlet weak var btn_AdditionalstopsRef: UIButton!
    @IBOutlet weak var btnplannedstops: UIButton!
    @IBOutlet weak var uourridehasbeenstarted_lblref: UILabel!

    //DRIVER DETAILS SHOWING IN PARTNER SIDE VIEW......
    @IBOutlet weak var view_DriverDetailsInPartnerSideRef: UIView!
    @IBOutlet weak var btn_CallToDriverRef: UIButton!
    @IBOutlet weak var btn_ChatToDriverRef: UIButton!
    @IBOutlet weak var lbl_ChatPushNotificationStatusFromDriverRef: UILabel!
    
    // Partner Side User Details
    @IBOutlet weak var imageviewref: UIImageView!
    @IBOutlet weak var userName_lblref: UILabel!
    @IBOutlet weak var UserNumber_lblref:UILabel!
    @IBOutlet weak var callbuttonref: UIButton!
    @IBOutlet weak var messagebuttonref: UIButton!

    // Partner Side Driver Details
    @IBOutlet weak var lbl_DriverNumberRef: UILabel!
    @IBOutlet weak var lbl_DriverNameRef: UILabel!
    @IBOutlet weak var imageview_DriverImageRef: UIImageView!
    @IBOutlet weak var lbl_DriverRideInfoRef: UILabel!
    @IBOutlet weak var btn_WaitingChargesStartRef: UIButton!
    @IBOutlet weak var btn_PartnerCancelRideRef: UIButton!
    
    // waiting time alert type
    @IBOutlet weak var AdditionalStopsTextfield: UITextField!
    @IBOutlet weak var waitingTimetextfield: UITextField!
    @IBOutlet weak var cancelbtn: UIButton!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var cancelWaitingviewbtn: UIButton!
    @IBOutlet weak var AdditionalWaitingView: UIView!

    //
    @IBOutlet weak var dateandtimeshowinglbl_ref: UILabel!
    @IBOutlet weak var plannedstopslbl_ref: UILabel!
    
    var driverCurrentLatitudeValue = Double()
    var driverCurrentLongitudeValue = Double()
    var geoCoder: CLGeocoder?
    var placeMark: CLPlacemark?
    var str_DriverCurrentLocationLatitude = String()
    var str_DriverCurrentLocationLongitude = String()
    var str_DriverNumberForPartner = String()
    var str_DriverIDForPartner = String()
    var str_userNumberForPartner = String()
    var str_userIDForPartner = String()
    var str_UserMobileNumber = String()
    var str_RideUserID = String()
    var str_PartnerIDForDriver = String()
    var str_PartnerPhoneNoForDriver = String()
    var str_PartnerNameForDriver = String()
    var str_PartnerEmailForDriver = String()
    var str_CurrentRideID = String()
    var driverLoginIDString = String()
    var str_DerviceToken = String()
    //NSUserDefaults *defaultsForSave;
    var isCheckingRideStartCompleteStatus = Bool()
    var str_FutureRideStart = String()
    var str_AdditionalStopsArr : [DriverFutureRideDetailsPlanned_address] = []
    var str_RideStartLocationLatitude = String()
    var str_RideStartLocationLongitude = String()
    var str_RideEndLocationLatitude = String()
    var str_RideEndLocationLongitude = String()
    var currentDate = String()
    var str_RideCost = String()
    var str_WaitingCharges = String()
    var str_TotalCharges = String()
    var str_earnings = String()
    var str_ride_fare = String()
    var Str_AdminFare = String()
    var str_CurrentRideUsername = String()
    var str_CurrentRideUserImageUrl = String()
    // taking start time as a strings
    var str_Startdate = String()
    var str_Stopdate = String()
    var timecases  = String()
    var makingcases  = String()
    var typecases  = String()
    var pickerView = UIPickerView()
    var toolBar = UIToolbar()
    var pickerData = Array<String>()
    var pickerData2 = Array<String>()
    var pickerData3 = Array<String>()
    var picktype  = String()
    var stopsPickerStr = String()
    var waitingTimePickerStr = String()
    var selectedTxtFldType = String()
    var str_datEtime = String()
    var complitebuttonstatus = String()
    var str_plannedstops = String()
    var str_Partnerloc_lat = String()
    var str_partnerloc_long = String()
    var str_partnerpick_lat = String()
    var str_partnerpick_long = String()
    var str_partnerDrop_lat = String()
    var str_partnerDrop_long = String()
    var str_AppVersion = String()
    var timer_ForUpdatingDriverCurrentLocation: Timer?
  //  var locationManager: CLLocationManager!
    
    let getLocation = GetLocation()




    override func viewDidLoad() {
        super.viewDidLoad()
        if ((timer_ForUpdatingDriverCurrentLocation?.isValid) != nil) {
            timer_ForUpdatingDriverCurrentLocation?.invalidate()
            timer_ForUpdatingDriverCurrentLocation = nil
        }
        self.driverUpdateLocationmethod()
        
        self.title = "Accepted Future Ride Details"
        picktype = "yes"
        self.str_AppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        
        pickerData = ["00:00","00:15 min", "00:30 min", "00:45 min", "01:00 hr", "01:15 hr", "01:30 hr" ,"01:45 hr", "02:00 hr", "02:15 hr", "02:30 hr", "02:45 hr", "03:00 hr", "03:15 hr", "03:30 hr", "03:45 hr", "04:00 hr"]
        pickerData2 = ["00","01", "02", "03", "04", "05", "06" ,"07", "08", "09", "10", "11", "12", "13", "14", "15", "16"]
        pickerData3 = ["00:00","15", "30", "45", "60", "75", "90" ,"105", "120", "135", "150", "165", "180", "195", "210", "225", "240"]
        
        pickerView.delegate = self;
        AdditionalWaitingView.isHidden = true
        timecases = "1"
        typecases = "1"
       // timershowview_ref.isHidden = true
        uourridehasbeenstarted_lblref.isHidden = true
        
         Timer.scheduledTimer(timeInterval: 1.0,
                                   target: self,
                                 selector: #selector(self.timeNotify),
                                 userInfo: nil,
                                  repeats: true)
        
        driverLoginIDString = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        str_DerviceToken = UserDefaults.standard.string(forKey: "FCMDeviceToken") ?? ""
        
        self.view_DriverDetailsInPartnerSideRef.isHidden = true
        self.view_UserDetailsInfoInDriverSideRef.isHidden = true
        self.viewUserScrollref.isHidden = true
        self.imageview_UserNameRef.layer.cornerRadius = 30
        self.imageview_UserNameRef.layer.borderWidth = 1
        self.imageview_UserNameRef.layer.borderColor = UIColor.white.cgColor
        self.imageview_UserNameRef.layer.masksToBounds = true
        self.imageview_DriverImageRef.layer.cornerRadius = 30
        self.imageview_DriverImageRef.layer.borderWidth = 1
        self.imageview_DriverImageRef.layer.borderColor = UIColor.white.cgColor
        self.imageview_DriverImageRef.layer.masksToBounds = true
        
        self.imageviewref.layer.cornerRadius = 30
        self.imageviewref.layer.borderWidth = 1
        self.imageviewref.layer.borderColor = UIColor.white.cgColor
        self.imageviewref.layer.masksToBounds = true
        
        if btn_StartRideFromDriverRef.title(for: .normal) == "COMPLETE RIDE" {
            isCheckingRideStartCompleteStatus = true
        }
        
        self.btn_PartnerCancelRideRef.layer.cornerRadius = 5
        self.btn_PartnerCancelRideRef.layer.masksToBounds = true

        if self.str_ComingFrom == "Driver" {
            // Location Updating.....
            if askEnableLocationService() == "YES" {
                getLocation.run { [self] in
                    if let location = $0 {
                        print("location = \(location.coordinate.latitude) \(location.coordinate.longitude)")
                        driverCurrentLatitudeValue = location.coordinate.latitude
                        driverCurrentLongitudeValue = location.coordinate.longitude
                        str_DriverCurrentLocationLatitude = String(driverCurrentLatitudeValue) ?? ""
                        str_DriverCurrentLocationLongitude = String(driverCurrentLongitudeValue) ?? ""
                    } else {
                        print("Get Location failed \(self.getLocation.didFailWithError)")
                    }
                }
            }
            // Location Updating.....
            
            self.driverFutureRideDetailsAPI(withDriverID: driverLoginIDString, withFutureRideID: self.str_SelectedRideID)
            str_RideStartLocationLatitude = self.dict_RideInfo?.pickup_lat ?? ""
            str_RideStartLocationLongitude = self.dict_RideInfo?.pickup_long ?? ""
            
            self.manualTransmission_Lblref.text = "Transmission : " + (self.dict_RideInfo?.car_transmission ?? "") ?? ""
            
            str_datEtime = (self.dict_RideInfo?.date ?? "") ?? "" + " " + (self.dict_RideInfo?.time ?? "") ?? ""
            dateandtimeshowinglbl_ref.text = "Date/Time: " + str_datEtime
            
            str_RideEndLocationLatitude = self.dict_RideInfo?.d_lat ?? ""
            str_RideEndLocationLongitude = self.dict_RideInfo?.d_long ?? ""



        } else {
            self.partnerFutureRideDetailsAPI(withDriverID: driverLoginIDString, withFutureRideID: self.str_SelectedRideID)
        }
        
        
        self.pickerView = UIPickerView()

        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        self.AdditionalStopsTextfield.inputView = self.pickerView
        self.waitingTimetextfield.inputView = self.pickerView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if ((timer_ForUpdatingDriverCurrentLocation?.isValid) != nil) {
            timer_ForUpdatingDriverCurrentLocation?.invalidate()
            timer_ForUpdatingDriverCurrentLocation = nil
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if ((timer_ForUpdatingDriverCurrentLocation?.isValid) != nil) {
            timer_ForUpdatingDriverCurrentLocation?.invalidate()
            timer_ForUpdatingDriverCurrentLocation = nil
        }
    }

    
    @IBAction func btn_GoToUserStartLocationNavActionRef(_ sender: Any) {
        let googleMapUrlString = "http://maps.google.com/?saddr=\(str_DriverCurrentLocationLatitude),\(str_DriverCurrentLocationLongitude)&daddr=\(str_RideStartLocationLatitude),\(str_RideStartLocationLongitude)"
        let application = UIApplication.shared
        if let anURL = URL(string: googleMapUrlString) as? URL {
            application.open(anURL, options: [:]) { success in
            }
        }
    }
    @IBAction func btn_StartRideFromDriverActionRef(_ sender: Any) {
        if isCheckingRideStartCompleteStatus == false {
            var mutableDat = ""
            if let dateStr = self.dict_RideInfo?.date, let timestr = self.dict_RideInfo?.time {
                mutableDat = dateStr + " " + timestr
            }
           // (self.dict_RideInfo?.date ?? "") ?? "" + " " + (self.dict_RideInfo?.time ?? "") ?? ""
            
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd hh:mm a"
            guard let startDate = dateFormat.date(from: mutableDat) else {return}
            
            let currDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
            guard let todayDate = dateFormatter.string(from: currDate) as? String else { return  }
            guard let endDate = dateFormatter.date(from: todayDate) else { return  }
            
            let distanceBetweenDates = startDate.timeIntervalSince(endDate)
            let secondsInAnHour: Double = 900
            let hoursBetweenDates = Int(distanceBetweenDates / secondsInAnHour)
            
            if distanceBetweenDates > 900 {
                self.ShowAlert(message: "Before 15Minutes Only You Can Start Ride")
            } else {
                uourridehasbeenstarted_lblref.isHidden = false
                //MARK: Driver Start Ride
                let dateFormatterrr = DateFormatter()
                let str_CurrentgetTime = dateFormatterrr.string(from: Date())
                
                if btn_StartRideFromDriverRef.title(for: .normal) == "COMPLETE RIDE" {
                    isCheckingRideStartCompleteStatus = true
                    AdditionalWaitingView.isHidden = false
                    
                    if AdditionalWaitingView.isHidden == false {
                        view_UserDetailsInfoInDriverSideRef.isHidden = false
                        self.viewUserScrollref.isHidden = false
                    }
                } else {
                    self.driverFutureRideStartAPI(withDriverID: driverLoginIDString,withCurrentTime: str_CurrentgetTime,withCurrentRideID : str_CurrentRideID)
                }
                
               // self.btn_WaitingChargesStartRef.isHidden = true
                self.btn_StartRideFromDriverRef.setTitle("COMPLETE RIDE", for: .normal)
                isCheckingRideStartCompleteStatus = true

            }
            
        } else {
            //MARK: Driver Completed Ride
            if isCheckingRideStartCompleteStatus {
                isCheckingRideStartCompleteStatus = false
                AdditionalWaitingView.isHidden = false

                if AdditionalWaitingView.isHidden == false {
                    view_UserDetailsInfoInDriverSideRef.isHidden = false
                    self.viewUserScrollref.isHidden = false
                }
            }
        }
    }
    
    //MARK: - == START RIDE BUTTON
    @IBAction func btn_StartRideLocationNavActionRef(_ sender: Any) {
        if str_FutureRideStart == "1" {
            let googleMapUrlString = "http://maps.google.com/?saddr=\(str_DriverCurrentLocationLatitude),\(str_DriverCurrentLocationLongitude)&daddr=\(str_RideEndLocationLatitude),\(str_RideEndLocationLongitude)"
            
            let application = UIApplication.shared
            if let anURL =  URL(string: googleMapUrlString) {
                application.open(anURL, options: [:]) { success in
                    if success {
                        print("Opened url")
                    }
                }
            }
        } else {
            let googleMapUrlString = "http://maps.google.com/?saddr=\(str_RideStartLocationLatitude),\(str_RideStartLocationLongitude)&daddr=\(str_RideEndLocationLatitude),\(str_RideEndLocationLongitude)"
            
            let application = UIApplication.shared
            if let anURL = URL(string: googleMapUrlString){
                application.open(anURL, options: [:]) { success in
                    if success {
                        print("Opened url")
                    }
                }
            }
        }
        
    }
    
    @IBAction func btn_CancelUserRideByDriverActionRef(_ sender: Any) {
        let alertController = UIAlertController(title: kApptitle, message: "Are you sure you want to cancel this ride?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            let Storyboard : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
            let nxtVC = Storyboard.instantiateViewController(withIdentifier: "CancelRideViewController") as! CancelRideViewController
            nxtVC.str_CurrentRideID = self.str_CurrentRideID
            nxtVC.str_ComingFrom = "FutureRide"
            nxtVC.str_PartnerID = self.str_PartnerIDForDriver
            self.navigationController?.pushViewController(nxtVC, animated: true)
        }
        
        let CancellAction = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
        }
        alertController.addAction(OKAction)
        alertController.addAction(CancellAction)
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func btn_CallToUserActionRef(_ sender: Any) {
        if str_UserMobileNumber == "" {
            self.ShowAlert(message: "Currently driver have No Number")
        } else {
            let application = UIApplication.shared
            if let anURL = URL(string: "\("tel://" + str_UserMobileNumber)"){
                application.open(anURL, options: [:]) { success in
                    if success {
                    }
                }
            }
        }
    }
    
    @IBAction func btn_ChatToUserActionRef(_ sender: Any) {
        UserDefaults.standard.set("Coming From Future Ride", forKey: "ChatFromLaunchScreen")
        
        let Storyboard : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        nxtVC.str_ChatStatus = "";
        nxtVC.recevierId = str_RideUserID;
        nxtVC.str_ChatType = "ToUser";
        self.navigationController?.pushViewController(nxtVC, animated: true)
    }
    
    @IBAction func btn_CallToDriverActionRef(_ sender: Any) {
        if str_DriverNumberForPartner == "" {
            self.ShowAlert(message:"Currently driver have No Number")
        } else {
            let application = UIApplication.shared
            if let anURL = URL(string: "\("tel://" + str_DriverNumberForPartner)"){
                application.open(anURL, options: [:]) { success in
                    if success {
                    }
                }
            }
        }
    }
    
    @IBAction func btn_ChatToDriverActionRef(_ sender: Any) {
        UserDefaults.standard.set("Coming From Future Ride", forKey: "ChatFromLaunchScreen")
        let Storyboard : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        nxtVC.str_ChatStatus = ""
        nxtVC.str_CurrentRideDriverID = str_DriverIDForPartner
        nxtVC.str_ChatType = "ToDriver"
        self.navigationController?.pushViewController(nxtVC, animated: true)

    }
    
    @IBAction func NumberpartnertoUserBtnref(_ sender: Any) {
        if str_userNumberForPartner == "" {
            self.ShowAlert(message: "Currently user have No Number")
        } else {
            let application = UIApplication.shared
            if let anURL = URL(string: "\("tel://" + str_userNumberForPartner)") {
                application.open(anURL, options: [:]) { success in
                    if success {
                    }
                }
            }
        }
    }
    
    @IBAction func partnerChattouserbtnref(_ sender: Any) {
        UserDefaults.standard.set("Coming From Future Ride", forKey: "ChatFromLaunchScreen")
        
        let Storyboard : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        nxtVC.str_ChatStatus = ""
        nxtVC.str_CurrentRideDriverID = str_userIDForPartner
        nxtVC.str_ChatType = "ToUser"
        self.navigationController?.pushViewController(nxtVC, animated: true)

    }
    
    @IBAction func btn_PartnerDetailsShowInDriverSideRef(_ sender: Any) {
        if str_PartnerIDForDriver == "" {
            self.ShowAlert(message: "no partner found")
        } else {
            let str_MessageWithEstimationTime = "\n Partner Name : \(str_PartnerNameForDriver) \n Partner EmailID: \(str_PartnerEmailForDriver) \n Partner Phone: \(str_PartnerPhoneNoForDriver) "
            
            let alertController = UIAlertController(title: "Partner Details", message: str_MessageWithEstimationTime, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btn_ChatToPartnerActionRef(_ sender: Any) {
        if str_PartnerIDForDriver == "" {
            self.ShowAlert(message: "no partner found")
        } else {
            UserDefaults.standard.set("Coming From Future Ride", forKey: "ChatFromLaunchScreen")
            
            let Storyboard : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
            let nxtVC = Storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
            nxtVC.str_ChatStatus = ""
            nxtVC.str_CurrentRidePartnerID = str_PartnerIDForDriver
            nxtVC.str_ChatType = "ToPartner"
            self.navigationController?.pushViewController(nxtVC, animated: true)

        }
    }
    
    @IBAction func btn_CallToPartnerActionRef(_ sender: Any) {
        if str_PartnerPhoneNoForDriver == "" {
            self.ShowAlert(message: "Currently Partner have No Number")
        } else {
            let application = UIApplication.shared
            if let anURL = URL(string: "\("tel://" + str_PartnerPhoneNoForDriver)"){
                application.open(anURL, options: [:]) { success in
                    if success {
                    }
                }
            }
        }
    }
    
    @IBAction func btn_IntimatePartnerActionRef(_ sender: Any) {
        if str_PartnerIDForDriver == "" {
            self.ShowAlert(message: "no partner found")
        } else {
            self.intimateToPartnerStartRideAPI(withRideID: str_CurrentRideID,withDriverID:driverLoginIDString)
        }
    }
    
    @IBAction func btn_WaitingChargesStartActionRef(_ sender: Any) {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd hh:mm a"
        currentDate = dateFormat.string(from: Date())
        
        self.WaitingChargesStartForFutureRideAPI(BasedOnDriverID :driverLoginIDString,withRideID : str_CurrentRideID,withWaitingChargesTime : currentDate)
    }
    
    @IBAction func btn_PartnerCancelRideActionRef(_ sender: Any) {
        let Storyboard : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "CancelRideViewController") as! CancelRideViewController
        nxtVC.str_CurrentRideID = self.str_CurrentRideID
        nxtVC.str_ComingFrom = "PartnerFutureRide"
        self.navigationController?.pushViewController(nxtVC, animated: true)
    }
    
    @IBAction func AddaditionalwaitingtimestopsButton(_ sender: Any) {
        typecases = "0"
        self.ShowAlert(message: "Added Successfully")
        if typecases == "0" {
            self.driverAdditionalstopswaitingtimeAPI(withRideID : str_CurrentRideID,
                                                   withDriverID : driverLoginIDString,
                                         withWaitingChargesTime : waitingTimePickerStr,
                                        withstr_unplanned_stops : stopsPickerStr)
        }
        AdditionalWaitingView.isHidden = true
    }

    @IBAction func AdditionalPlanedStopsbtnref(_ sender: Any) {
        if str_plannedstops != "" || str_plannedstops != "0" {
        let Storyboard : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "StopsViewController") as! StopsViewController
        nxtVC.dict_AdditionalStops = self.str_AdditionalStopsArr
        nxtVC.str_plannedstops = str_plannedstops
        self.navigationController?.pushViewController(nxtVC, animated: true)
        }
    }
    
    @IBAction func Additionalstops_btn(_ sender: Any) {
        if makingcases == "NO" {
            self.driverAdditionalStopsAPI(withRideID:str_CurrentRideID)
        }
    }
    
    @IBAction func CancelAdditionalWaitingtimeStopsButton(_ sender: Any) {
        AdditionalWaitingView.isHidden = true
        typecases = "0"
        
        self.driverAdditionalstopswaitingtimeAPI(withRideID : str_CurrentRideID,
                                    withDriverID : driverLoginIDString,
                                    withWaitingChargesTime : "0",
                                   withstr_unplanned_stops : "0")
        
       
    }
    
    //MARK: -== partner Navigation START RIDE BUTTON
    @IBAction func partner_navigation_btnref(_ sender: Any) {
        let googleMapUrlString = "http://maps.google.com/?saddr=\(str_Partnerloc_lat),\(str_partnerloc_long)&daddr=\(str_partnerpick_lat),\(str_partnerpick_long)"
        
        let application = UIApplication.shared
        if let anURL = URL(string: googleMapUrlString) {
            application.open(anURL, options: [:]) { success in
                if success {
                    print("Opened url")
                }
            }
        }
    }
    
    @IBAction func partner_Pick_to_Drop_loc_btnref(_ sender: Any) {
        let googleMapUrlString = "http://maps.google.com/?saddr=\(str_partnerpick_lat),\(str_partnerpick_long)&daddr=\(str_partnerDrop_lat),\(str_partnerDrop_long)"
        
        let application = UIApplication.shared
        if let anURL = URL(string: googleMapUrlString) {
            application.open(anURL, options: [:]) { success in
                if success {
                    print("Opened url")
                }
            }
        }
    }
    
    @IBAction func refereshbuttonref(_ sender : Any) {
        self.driverFutureRideDetailsAPI(withDriverID: driverLoginIDString, withFutureRideID: self.str_SelectedRideID)
    }
    
    @IBAction func WitingTimeBtn(_ sender : Any) {
        //timershowview_ref.isHidden = false
        if makingcases == "NO" {
            Timer.scheduledTimer(timeInterval: 1.0,
                                      target: self,
                                    selector: #selector(self.timeNotify),
                                    userInfo: nil,
                                     repeats: true)
            if timecases == "1" {
                var startdate = str_Startdate
                self.driverwaitingtimeAPI(withRideID: str_CurrentRideID, withstarttime: startdate, withendtime: "")
                start_timelblRef.text = "\("Waiting Time Was Start :")\(startdate)"
                timecases = "2"
            } else if timecases == "2" {
                self.driverwaitingtimeAPI(withRideID: str_CurrentRideID, withstarttime: str_Startdate, withendtime: str_Stopdate)
                start_timelblRef.text = "\("Waiting Time Was Stop :")\(str_Stopdate)"
                timecases = "1"
            }
            
        } else if makingcases == "YES" {
            
        }
    }
    
    @objc func timeNotify() {
        let currentTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let resultString = dateFormatter.string(from: currentTime)
        //NormalTimeRef.text = resultString
        
        if timecases == "1" {
            str_Startdate = resultString
        } else {
            str_Stopdate = resultString
        }
    }
}

extension OngoingRideDetailsViewController {
    //MARK: - driverAdditionalStopsAPIwithDriverID
    func driverAdditionalStopsAPI(withRideID: String) {
        //ride_id
        //API_AdditionalStops_URL
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        self.viewModel.requestFordriverAdditionalStopsAPIServices(perams: ["rideid":withRideID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                    self.ShowAlert(message: userData.message ?? "")
                } else {
                    self.showToast(message: userData.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
                }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? I18n.SomethingWentWrong, font: .systemFont(ofSize: 12.0))
                }
             }
        }
    }
}
extension OngoingRideDetailsViewController {
    //MARK: - WaitingChargesStartAPI
    func WaitingChargesStartForFutureRideAPI(BasedOnDriverID: String,withRideID :String,
withWaitingChargesTime: String) {
        
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForWaitingChargesStartAPIServices(perams: ["driverid":DriverLoginID,"rideid":withRideID,"waiting_charges_start_time": withWaitingChargesTime]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                    self.ShowAlert(message: userData.message ?? "")
                    } else {
                        self.showToast(message: userData.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? I18n.SomethingWentWrong, font: .systemFont(ofSize: 12.0))
                }
             }
        }
        
    }
}
extension OngoingRideDetailsViewController {
    //MARK: - driverwaiting time APIwithDriverID
    func driverwaitingtimeAPI(withRideID: String,withstarttime :String,
                              withendtime: String) {
        
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverWaitingTimeAPIServices(perams: ["ride_id":withRideID,"waiting_start_time":withstarttime,"waiting_end_time": withendtime]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                    self.ShowAlert(message: userData.message ?? "")
                    } else {
                        self.showToast(message: userData.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? I18n.SomethingWentWrong, font: .systemFont(ofSize: 12.0))
                }
             }
        }
        
    }
}
extension OngoingRideDetailsViewController {
    //MARK: - AdditionalStopswaitingtime
    func driverAdditionalstopswaitingtimeAPI(withRideID: String,withDriverID :String,
                                             withWaitingChargesTime: String, withstr_unplanned_stops: String) {
        
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForAdditionalStopswaitingtimeAPIServices(perams: ["rideid":withRideID,"driver_id":withDriverID,"waiting_time": withWaitingChargesTime,"unplanned_stops":withstr_unplanned_stops]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                   
                    if userData.status == "1" {
                    
                    str_earnings = userData.earnings ?? ""
                    str_ride_fare = userData.ride_fare ?? ""
                    Str_AdminFare = userData.admin_fee ?? ""
                    
                    let Storyboard : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
                    let rideChargesPreviewScreen = Storyboard.instantiateViewController(withIdentifier: "RideChargesPreviewViewController") as! RideChargesPreviewViewController
                    rideChargesPreviewScreen.str_waitingtime = waitingTimePickerStr;
                    rideChargesPreviewScreen.str_Additionalstops = stopsPickerStr;
                    rideChargesPreviewScreen.str_earnings = str_earnings;
                    rideChargesPreviewScreen.str_Ridefare = str_ride_fare;
                    rideChargesPreviewScreen.Str_AdminFare = Str_AdminFare;
                    rideChargesPreviewScreen.str_RideCost = str_RideCost;
                    rideChargesPreviewScreen.str_WaitingCharges = str_WaitingCharges;
                    rideChargesPreviewScreen.str_TotalRideCost = str_TotalCharges;
                    rideChargesPreviewScreen.str_CurrentRideID = self.str_SelectedRideID;
                    rideChargesPreviewScreen.str_RideUserID = str_RideUserID;
                    rideChargesPreviewScreen.str_ComingFrom = "Future Ride";
                    rideChargesPreviewScreen.str_UserName = str_CurrentRideUsername;
                    rideChargesPreviewScreen.str_UserimageUrl = str_CurrentRideUserImageUrl;
                    self.navigationController?.pushViewController(rideChargesPreviewScreen, animated: true)

                    } else {
                        let alertController = UIAlertController(title: kApptitle, message: model?.message ?? "Something went wrong!", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                           
                        let Storyboard : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
                        let rideChargesPreviewScreen = Storyboard.instantiateViewController(withIdentifier: "RideChargesPreviewViewController") as! RideChargesPreviewViewController

                        rideChargesPreviewScreen.str_waitingtime = waitingTimePickerStr;
                        rideChargesPreviewScreen.str_Additionalstops = stopsPickerStr;
                        rideChargesPreviewScreen.str_earnings = str_earnings;
                        rideChargesPreviewScreen.str_Ridefare = str_ride_fare;
                        rideChargesPreviewScreen.str_RideCost = str_RideCost;
                        rideChargesPreviewScreen.str_WaitingCharges = str_WaitingCharges;
                        rideChargesPreviewScreen.str_TotalRideCost = str_TotalCharges;
                        rideChargesPreviewScreen.str_CurrentRideID = self.str_SelectedRideID;
                        rideChargesPreviewScreen.str_RideUserID = str_RideUserID;
                        rideChargesPreviewScreen.str_ComingFrom = "Future Ride";
                        rideChargesPreviewScreen.str_UserName = str_CurrentRideUsername;
                        rideChargesPreviewScreen.str_UserimageUrl = str_CurrentRideUserImageUrl;

                        self.navigationController?.pushViewController(rideChargesPreviewScreen, animated: true)
                        }
                        alertController.addAction(OKAction)
                        self.present(alertController, animated: true, completion: nil)

                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? I18n.SomethingWentWrong, font: .systemFont(ofSize: 12.0))
                }
             }
        }
        
    }
}

extension OngoingRideDetailsViewController {
    //MARK: - DriverRideCompleteAPI
    func driverRideCompleteAPI(withDriverID: String, withUserID: String, withRideID: String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverRideCompleteAPIServices(perams: ["driverid":DriverLoginID,"ride_id":withRideID,"userid": withUserID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                    self.driverRidePaymentAPI(withUserID: str_RideUserID, withRideID: str_CurrentRideID)
                    } else {
                        self.showToast(message: userData.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? I18n.SomethingWentWrong, font: .systemFont(ofSize: 12.0))
                }
             }
        }
    }
}

extension OngoingRideDetailsViewController {
    //MARK: - DriverRideStartAPI
    func driverFutureRideStartAPI(withDriverID: String, withCurrentTime: String, withCurrentRideID: String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverRideStartAPIServices(perams: ["driverid":DriverLoginID,"rideid":withCurrentRideID,"time": withCurrentTime]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                    self.str_RideCost = userData.ride_cost ?? ""
                    self.str_WaitingCharges = userData.waiting_charge ?? ""
                    self.str_TotalCharges = userData.total_cost ?? ""

                    self.ShowAlert(message: userData.message ?? "Started...")
                    } else {
                        self.showToast(message: userData.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? I18n.SomethingWentWrong, font: .systemFont(ofSize: 12.0))
                }
             }
        }

    }
}
extension OngoingRideDetailsViewController {
    //MARK: - DriverFutureRideDetailsAPI
    func driverFutureRideDetailsAPI(withDriverID: String, withFutureRideID: String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverFutureRideDetailsAPIServices(perams: ["driver_id":DriverLoginID,"ride_id":withFutureRideID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    
                    if userData.status == "1" {
                    
                    let waitingtimestatus = userData.waiting_status ?? ""
                    if waitingtimestatus == "" {
                       // btn_waitingtimeRef.setTitle(" Waiting Time", for: .normal)
                    } else if waitingtimestatus == "start" {
                       // btn_waitingtimeRef.setTitle(" Stop Waiting Time", for: .normal)
                    }else if waitingtimestatus == "stop" {
                       // btn_waitingtimeRef.setTitle(" Stop Waiting Time", for: .normal)
                    }
                    self.view_DriverDetailsInPartnerSideRef.isHidden = true
                    self.view_UserDetailsInfoInDriverSideRef.isHidden = false
                    self.viewUserScrollref.isHidden = false
                    //User Details.............
                    if let response  = userData.planned_address as? [DriverFutureRideDetailsPlanned_address] {
                    str_AdditionalStopsArr = response
                    }
                    str_FutureRideStart = userData.data?.future_ride_start ?? ""
                    
                    if str_FutureRideStart == "" {
                        isCheckingRideStartCompleteStatus = false
                        //self.btn_WaitingChargesStartRef.isHidden = false
                        btn_StartRideFromDriverRef.setTitle("START RIDE", for: .normal)
                        uourridehasbeenstarted_lblref.isHidden = true
                    } else if str_FutureRideStart == "0" {
                        str_FutureRideStart = ""
                        isCheckingRideStartCompleteStatus = false
                        btn_StartRideFromDriverRef.setTitle("START RIDE", for: .normal)
                        uourridehasbeenstarted_lblref.isHidden = true
                        makingcases = "yes"
                        //timershowview_ref.isHidden = true
                    } else {
                        makingcases = "NO"
                        //self.btn_WaitingChargesStartRef.isHidden = true
                        isCheckingRideStartCompleteStatus = true
                        uourridehasbeenstarted_lblref.isHidden = false
                        btn_StartRideFromDriverRef.setTitle("COMPLETE RIDE", for: .normal)
                        str_RideCost = userData.ride_cost ?? ""
                        str_WaitingCharges = userData.waiting_charge ?? ""
                        str_TotalCharges = userData.total_cost ?? ""
                    }
                    let userFirstName = userData.data?.userfname ?? ""
                    let userLastName = userData.data?.userlname ?? ""
                    self.lbl_UserNameRef.text = userFirstName + " " + userLastName
                    str_CurrentRideUsername = self.lbl_UserNameRef.text ?? userFirstName + " " + userLastName
                    str_UserMobileNumber = userData.data?.usermobile ?? ""
                    self.lbl_UserNumberRef.text = str_UserMobileNumber
                    str_plannedstops = userData.planned_stops ?? ""
                    self.plannedstopslbl_ref.text = "Planned Stops :" + (str_plannedstops)
                    btnplannedstops.isHidden = str_plannedstops.count > 0 ? false : true
                    str_RideUserID = userData.data?.userid ?? ""
                    str_CurrentRideID = userData.data?.rideid ?? ""
                    //user Profile Pic
                    if let Str_UserImage = userData.data?.userpic {
                        self.imageview_UserNameRef.sd_setImage(with: URL(string: API_URl.API_IMAGEBASE_URL + Str_UserImage), placeholderImage: UIImage(named: "personIcon"))
                    } else {
                        self.imageview_UserNameRef.image = UIImage(named: "personIcon")
                    }
                    
                    //Partner Details..............
                    var partnerFirstName = userData.data?.partnerfname ?? ""
                    var partnerLastName = userData.data?.partnerlname ?? ""
                    str_PartnerNameForDriver = partnerFirstName + partnerLastName
                    
                    str_PartnerPhoneNoForDriver = userData.data?.partnermobile ?? ""
                    str_PartnerIDForDriver = userData.data?.partnerid ?? ""
                    str_PartnerEmailForDriver = userData.data?.partneremail ?? ""
                    var rideStartLocation = userData.data?.pickup_address ?? ""
                    var rideEndLocation = userData.data?.drop_address ?? ""
                    
                    let AttributeStr = "Ride From : " + (rideStartLocation ?? "") + "\n Ride To : " + (rideEndLocation ?? "")
                    let attrStri = NSMutableAttributedString.init(string:AttributeStr)
                    var nsRange = NSString(string: AttributeStr).range(of: "Ride From :", options: String.CompareOptions.caseInsensitive)
                    attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                    nsRange = NSString(string: AttributeStr).range(of: "Ride To :", options: String.CompareOptions.caseInsensitive)
                    attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                    self.lbl_UserRideInfoRef.attributedText = attrStri
                    } else {
                        self.ShowAlert(message: model?.message ??  I18n.SomethingWentWrong)
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? I18n.SomethingWentWrong, font: .systemFont(ofSize: 12.0))
                }
             }
        }
    }
}

extension OngoingRideDetailsViewController {
    //MARK: - PartnerFutureRideDetailsAPI
    func partnerFutureRideDetailsAPI(withDriverID: String, withFutureRideID: String){
        //driver_id=%@&ride_id
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForPartnerFutureRideDetailsAPIServices(perams: ["driver_id":DriverLoginID,"ride_id":withFutureRideID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    
                    if userData.status == "1" {
                    self.view_DriverDetailsInPartnerSideRef.isHidden = false
                    self.view_UserDetailsInfoInDriverSideRef.isHidden = true
                    self.viewUserScrollref.isHidden = true
                    
                    if askEnableLocationService() == "YES" {
                        getLocation.run { [self] in
                            if let location = $0 {
                                print("location = \(location.coordinate.latitude) \(location.coordinate.longitude)")
                                driverCurrentLatitudeValue = location.coordinate.latitude
                                driverCurrentLongitudeValue = location.coordinate.longitude
                                str_Partnerloc_lat = String(driverCurrentLatitudeValue) ?? ""
                                str_partnerloc_long = String(driverCurrentLongitudeValue) ?? ""
                            } else {
                                print("Get Location failed \(self.getLocation.didFailWithError)")
                            }
                        }
                    }
                    
                    self.str_partnerpick_lat = userData.data?.pickup_lat ?? ""
                    self.str_partnerpick_long = userData.data?.pickup_long ?? ""
                    self.str_partnerDrop_lat = userData.data?.d_lat ?? ""
                    self.str_partnerDrop_long = userData.data?.d_long ?? ""

                    // User Details
                    let UserFirstName = userData.data?.user_first_name ?? ""
                    let UserLastName = userData.data?.user_last_name ?? ""
                    self.userName_lblref.text = UserFirstName + UserLastName
                    //user Profile Pic
                    if let Str_UserImage = userData.data?.user_profile_pic {
                        self.imageviewref.sd_setImage(with: URL(string: API_URl.API_IMAGEBASE_URL + Str_UserImage), placeholderImage: UIImage(named: "personIcon"))
                    } else {
                        self.imageviewref.image = UIImage(named: "personIcon")
                    }
                    //user Mobile Number
                    str_userIDForPartner = userData.data?.user_id ?? ""
                    str_userNumberForPartner = userData.data?.user_mobile ?? ""
                    self.UserNumber_lblref.text = str_userNumberForPartner
                    
                    //Driver Details..............
                    let DriverFirstName = userData.data?.first_name ?? ""
                    let DriverLastName = userData.data?.last_name ?? ""
                    self.lbl_DriverNameRef.text = DriverFirstName + DriverLastName
                    
                    let str_plannedstops = userData.data?.planned_stops ?? ""
                    self.plannedstopslbl_ref.text = "Planned Stops : " + str_plannedstops
                    
                    str_DriverIDForPartner = userData.data?.id ?? ""
                    str_DriverNumberForPartner = userData.data?.mobile ?? ""
                    str_CurrentRideID = userData.data?.rideid ?? ""
                    self.lbl_DriverNumberRef.text = str_DriverNumberForPartner
                    
                    var rideStartLocation = userData.data?.pickup_address
                    var rideEndLocation = userData.data?.drop_address
                    
                    let AttributeStr = "Ride From : " + (rideStartLocation ?? "") + "\n Ride To : " + (rideEndLocation ?? "")
                    let attrStri = NSMutableAttributedString.init(string:AttributeStr)
                    var nsRange = NSString(string: AttributeStr).range(of: "Ride From :", options: String.CompareOptions.caseInsensitive)
                    attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                    
                    nsRange = NSString(string: AttributeStr).range(of: "Ride To :", options: String.CompareOptions.caseInsensitive)
                    attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange)
                    self.lbl_DriverRideInfoRef.attributedText = attrStri

                    str_FutureRideStart = userData.data?.future_ride_start ?? ""
                    if str_FutureRideStart == "" {
                        self.lbl_RideIsStartForPartnerSide.text = "Driver Details:"
                    } else if str_FutureRideStart == "0" {
                        self.lbl_RideIsStartForPartnerSide.text = "Driver Details:";
                    } else {
                        let AttributeStr2 = "Driver Details:\n Ride Started Driver"
                        let attrStri2 = NSMutableAttributedString.init(string:AttributeStr2)
                        var nsRange2 = NSString(string: AttributeStr2).range(of: "Ride Started Driver", options: String.CompareOptions.caseInsensitive)
                        attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.green], range: nsRange2)
                        self.lbl_RideIsStartForPartnerSide.attributedText = attrStri2
                    }
                    
                    //user Profile Pic
                    if let Str_UserImage = userData.data?.profile_pic {
                        self.imageview_DriverImageRef.sd_setImage(with: URL(string: API_URl.API_IMAGEBASE_URL + Str_UserImage), placeholderImage: UIImage(named: "personIcon"))
                    } else {
                        self.imageview_DriverImageRef.image = UIImage(named: "personIcon")
                    }
                    } else {
                        self.ShowAlert(message: model?.message ??  I18n.SomethingWentWrong)
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? I18n.SomethingWentWrong, font: .systemFont(ofSize: 12.0))
                }
             }
        }

    }
}
extension OngoingRideDetailsViewController {
    //MARK: - DriverRidePaymentAPI
    func driverRidePaymentAPI(withUserID: String, withRideID: String) {
        //user_id=%@&booking_id
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverRidePaymentAPIServices(perams: ["user_id":withUserID,"booking_id":withRideID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                        self.ShowAlert(message: "Payment Done Successfully")
                    } else {
                        self.ShowAlert(message: model?.message ??  "Payment failed")
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? I18n.SomethingWentWrong, font: .systemFont(ofSize: 12.0))
                }
            }
        }
        
    }
}

extension OngoingRideDetailsViewController {
    //MARk: - IntimateToPartnerStartRideAPI
    func intimateToPartnerStartRideAPI(withRideID: String, withDriverID: String) {
        //rideid=%@&driverid
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForIntimateToPartnerStartRideAPIServices(perams: ["driverid":DriverLoginID,"rideid":withRideID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                    self.ShowAlert(message: userData.message ?? "success")
                    } else {
                        self.showToast(message: userData.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? I18n.SomethingWentWrong, font: .systemFont(ofSize: 12.0))
                }
             }
        }

    }
}

extension OngoingRideDetailsViewController {
    //MARK: - DriverUpdateCurrentLocationAPI
    func driverUpdateCurrentLocationAPI(withCurrentLatitude: String, withCurrentLongitude: String) {
        //rideid=%@&driverid
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverUpdateCurrentLocationAPIServices(perams: ["driverid":DriverLoginID,"latitude":withCurrentLatitude,"longitude":withCurrentLongitude,"app_version" : str_AppVersion]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                }
             }
        }

    }
}


extension OngoingRideDetailsViewController {
    
    func driverUpdateLocationmethod() {
        if ((timer_ForUpdatingDriverCurrentLocation?.isValid) != nil) {
            timer_ForUpdatingDriverCurrentLocation?.invalidate()
            timer_ForUpdatingDriverCurrentLocation = nil
        }
        timer_ForUpdatingDriverCurrentLocation = Timer.scheduledTimer(timeInterval: 15.0,
                                   target: self,
                                 selector: #selector(self.method_UpdatingDriverCurrentLocation),
                                 userInfo: nil,
                                  repeats: true)
    }
    
    @objc func method_UpdatingDriverCurrentLocation() {
        self.driverUpdateCurrentLocationAPI(withCurrentLatitude: str_DriverCurrentLocationLatitude,withCurrentLongitude: str_DriverCurrentLocationLongitude)
    }
}
extension OngoingRideDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if selectedTxtFldType == "stops" {
            return pickerData2[row]
        } else if selectedTxtFldType == "waitingtime" {
            return pickerData[row]
        } else {
            return ""
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectedTxtFldType == "stops" {
            self.AdditionalStopsTextfield.text = pickerData2[row]
            self.stopsPickerStr = pickerData2[row]
        } else if selectedTxtFldType == "waitingtime" {
            self.waitingTimetextfield.text = pickerData[row]
            self.waitingTimePickerStr = pickerData[row]
        }
    }
}

extension OngoingRideDetailsViewController : UITextFieldDelegate {
    func noOfStopsPickerview(_ sender: Any) {
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        pickerView.showsSelectionIndicator = true
        pickerView.dataSource = self
        pickerView.delegate = self
        self.AdditionalStopsTextfield.inputView = pickerView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        toolBar.barStyle = .blackTranslucent
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTouchedstatus))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:#selector(cancelTouchedstatus))
                                           
        toolBar.items = [cancelButton, UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        self.AdditionalStopsTextfield.inputAccessoryView = toolBar
    }
    
    func waitingTimepickerview(_ sender: Any){
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        pickerView.showsSelectionIndicator = true
        pickerView.dataSource = self
        pickerView.delegate = self
        self.AdditionalStopsTextfield.inputView = pickerView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        toolBar.barStyle = .blackTranslucent
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTouchedstatus))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:#selector(cancelTouchedstatus))
                                           
        toolBar.items = [cancelButton, UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        self.waitingTimetextfield.inputAccessoryView = toolBar
    }
    
    @objc func cancelTouchedstatus(_ sender: UIBarButtonItem) {
        self.AdditionalStopsTextfield.resignFirstResponder()
        self.waitingTimetextfield.resignFirstResponder()
    }
    
    @objc func doneTouchedstatus(_ sender: UIBarButtonItem) {
        if selectedTxtFldType == "stops" {
            if self.AdditionalStopsTextfield.text?.count == 0 {
                self.AdditionalStopsTextfield.text = "00"
            }
        } else if selectedTxtFldType == "waitingtime" {
            if waitingTimetextfield.text?.count == 0 {
                waitingTimetextfield.text = "00"
            }
        }
        self.AdditionalStopsTextfield.resignFirstResponder()
        self.waitingTimetextfield.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == waitingTimetextfield {
            selectedTxtFldType = "waitingtime"
            self.waitingTimepickerview(self)
        } else if textField == AdditionalStopsTextfield {
            selectedTxtFldType = "stops"
            self.noOfStopsPickerview(self)
        }
    }
}
