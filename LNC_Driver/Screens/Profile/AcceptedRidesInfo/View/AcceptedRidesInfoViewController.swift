//
//  AcceptedRidesInfoViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 01/10/22.
//

import UIKit

class AcceptedRidesInfoViewController: UIViewController {

    @IBOutlet weak var btn_DriverAcceptedFutureRideRef: UIButton!
    @IBOutlet weak var btn_PartnerAcceptedFutureRideRef: UIButton!
    @IBOutlet weak var tableview_AcceptedFutureRideList: UITableView!
    @IBOutlet weak var lbl_NoFutureRideFound: UILabel!
    
    var str_ComingFromFutureRide = ""
    var str_ComingFromSliderStatus = ""
    var str_DriverRole = ""
    var loginDriverIDStr = ""
    var str_SelectedType = ""
    
    var str_SelectedRideID = ""
    
    var rideInfoDict:RideReservationsDatar?
    
    var ary_AcceptedFutureRideInfoRef:[RideReservationsDatar] = []
    var ary_FutureRideEstimatedDropDateRef: [String] = []
    var str_dateandtime = ""
    lazy var viewModel = {
        AcceptedRidesInfoViewModel()
    }()
    
    var RoleChangeStatus_Str = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btn_DriverAcceptedFutureRideRef.tag = 100
        self.btn_PartnerAcceptedFutureRideRef.tag = 101
        self.tableview_AcceptedFutureRideList.estimatedRowHeight = 1000
        self.tableview_AcceptedFutureRideList.rowHeight = UITableView.automaticDimension
        self.title = "Accepted Future Rides"
        self.loginDriverIDStr = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        self.lbl_NoFutureRideFound.isHidden = true
        //self.tableview_AcceptedFutureRideList.isHidden = true
        
        if self.str_ComingFromFutureRide == "PartnerFutureRideList" {
            str_SelectedType = "Partner"
            self.btn_DriverAcceptedFutureRideRef.backgroundColor = .gray
            self.btn_PartnerAcceptedFutureRideRef.backgroundColor = .green
            //Partner Accepted List API Calling....
            self.partnerAcceptedFutureRideListAPI(withDriverLoginID: loginDriverIDStr)
        } else {
            str_SelectedType = "Driver"
            
            self.btn_DriverAcceptedFutureRideRef.backgroundColor = .green
            self.btn_PartnerAcceptedFutureRideRef.backgroundColor = .gray
            
            self.driverAcceptedFutureRideListAPI(withDriverLoginID: loginDriverIDStr)
        }

        if self.str_DriverRole == "Your role is changed from driver to partner." {
            str_SelectedType = "Partner"
            
            self.btn_DriverAcceptedFutureRideRef.backgroundColor = .gray
            self.btn_PartnerAcceptedFutureRideRef.backgroundColor = .green
            
            self.partnerAcceptedFutureRideListAPI(withDriverLoginID: loginDriverIDStr)

        } else if str_DriverRole == "Your role is changed from partner to driver." {
            str_SelectedType = "Driver"
            
            self.btn_DriverAcceptedFutureRideRef.backgroundColor = .green
            self.btn_PartnerAcceptedFutureRideRef.backgroundColor = .gray
            
            self.driverAcceptedFutureRideListAPI(withDriverLoginID: loginDriverIDStr)
        }

    }
    
    @IBAction func openMenuBtnref(_ sender: Any) {
        self.navigateToSideMenu()
    }
    
    
    @IBAction func btn_DriverPartnerAcceptedFutureRideAction(_ sender: UIButton) {
        self.btn_DriverAcceptedFutureRideRef.backgroundColor = .gray
        self.btn_PartnerAcceptedFutureRideRef.backgroundColor = .gray
        self.ary_AcceptedFutureRideInfoRef.removeAll()
        self.tableview_AcceptedFutureRideList.reloadData()
        switch sender.tag {
        case 100:
            str_SelectedType = "Driver"
            self.btn_DriverAcceptedFutureRideRef.backgroundColor = .green
            self.btn_PartnerAcceptedFutureRideRef.backgroundColor = .gray
//Api Calling
             self.driverAcceptedFutureRideListAPI(withDriverLoginID: loginDriverIDStr)
            break
        case 101:
            str_SelectedType = "Partner"
            self.btn_DriverAcceptedFutureRideRef.backgroundColor = .gray
            self.btn_PartnerAcceptedFutureRideRef.backgroundColor = .green
//Api Calling
             self.partnerAcceptedFutureRideListAPI(withDriverLoginID: loginDriverIDStr)
            break
            
        default:
            print("")
        }
    }
}

extension AcceptedRidesInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView, ArrayCount: ary_AcceptedFutureRideInfoRef.count, numberOfsections: 1, data_MSG_Str: "No records found!")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary_AcceptedFutureRideInfoRef.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:AcceptedRidesInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AcceptedRidesInfoTableViewCell", for: indexPath) as? AcceptedRidesInfoTableViewCell else {return UITableViewCell()}
        /* Date */
        var str_FutureRidedate = ary_AcceptedFutureRideInfoRef[indexPath.row].otherdate ?? ""
        /*Time */
        var str_FutureRideTime = ary_AcceptedFutureRideInfoRef[indexPath.row].time ?? ""
        /*Estimation Time */
        var str_FutureRideEstimationDropTime = ary_AcceptedFutureRideInfoRef[indexPath.row].estimation_time ?? ""
        //
        var str_FutureRideEstimationDropDate_Time = ""
        
        if ary_FutureRideEstimatedDropDateRef.count == ary_AcceptedFutureRideInfoRef.count {
            str_FutureRideEstimationDropDate_Time = ary_FutureRideEstimatedDropDateRef[indexPath.row]
        }
        
        //
        str_dateandtime = str_FutureRidedate + " " + str_FutureRideTime
        
        //Notes
        var str_notes = ary_AcceptedFutureRideInfoRef[indexPath.row].notes ?? ""
        // str_Distance
        var str_Distance = ary_AcceptedFutureRideInfoRef[indexPath.row].distance ?? ""
        let distanceFloat = Float(str_Distance) ?? 0.00
        // pickup Address
        var str_pickupAddress = ary_AcceptedFutureRideInfoRef[indexPath.row].pickup_address ?? ""
        // Drop Address
        var str_dropAddress = ary_AcceptedFutureRideInfoRef[indexPath.row].drop_address ?? ""
        
        let AttributeStr2 = "Date/Time : " + str_dateandtime + "\n\nPickup : " + str_pickupAddress + "\n\nDropoff : " + str_dropAddress + "\nDistance : " + "\(distanceFloat)" + " Miles\n\nDuration : " + str_FutureRideEstimationDropTime + "\n\nEstimated DropOff Date/Time : " + str_FutureRideEstimationDropDate_Time + "\nNotes :" + str_notes
        let attrStri2 = NSMutableAttributedString.init(string:AttributeStr2)
        
        var nsRange2 = NSString(string: AttributeStr2).range(of: "Date/Time :", options: String.CompareOptions.caseInsensitive)
        attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange2)
        
        nsRange2 = NSString(string: AttributeStr2).range(of: "Pickup :", options: String.CompareOptions.caseInsensitive)
        attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange2)
        
        nsRange2 = NSString(string: AttributeStr2).range(of: "Dropoff :", options: String.CompareOptions.caseInsensitive)
        attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange2)
        
        nsRange2 = NSString(string: AttributeStr2).range(of: "Duration :", options: String.CompareOptions.caseInsensitive)
        attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 197.0/255.0, green: 0.0/255.0, blue: 1.0/255, alpha: 1.0)], range: nsRange2)

        nsRange2 = NSString(string: AttributeStr2).range(of: "Estimated DropOff Date/Time :", options: String.CompareOptions.caseInsensitive)
        attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange2)
        
        nsRange2 = NSString(string: AttributeStr2).range(of: "Notes :", options: String.CompareOptions.caseInsensitive)
        attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange2)

        nsRange2 = NSString(string: AttributeStr2).range(of: "Distance :", options: String.CompareOptions.caseInsensitive)
        attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange2)

        
        cell.lbl_RideDateRef.attributedText = attrStri2
        
        
        /* Button for stops  */
        let RoleChangeStatus_Str = ary_AcceptedFutureRideInfoRef[indexPath.row].future_partner_id ?? ""
        let Ridestatus_Str = ary_AcceptedFutureRideInfoRef[indexPath.row].status ?? ""
        
        if Ridestatus_Str == "0" {
            if Ridestatus_Str == "" {
                self.RoleChangeStatus_Str = ""
                cell.RoleChangeBtnHeight_ref.constant = 0
                cell.backViewBtn_height_ref.constant = 45
                
                cell.btn_RoleChangeBtnRef.isHidden = true
            } else {
                if RoleChangeStatus_Str == loginDriverIDStr {
                    cell.RoleChangeBtnHeight_ref.constant = 0
                    cell.backViewBtn_height_ref.constant = 45
                    cell.btn_RoleChangeBtnRef.isHidden = true
                } else {
                    cell.RoleChangeBtnHeight_ref.constant = 40
                    cell.backViewBtn_height_ref.constant = 100
                    cell.btn_RoleChangeBtnRef.isHidden = false
                    
                }
            }
        }
        
        if str_SelectedType == "Driver" {
            cell.btn_RoleChangeBtnRef.isHidden = false
        } else {
            cell.btn_RoleChangeBtnRef.isHidden = true
        }
        /* Button for stops  */
        cell.btn_RoleChangeBtnRef.layer.cornerRadius = 5.0
        cell.btn_RoleChangeBtnRef.layer.masksToBounds = true
        cell.btn_RoleChangeBtnRef.tag = indexPath.row;
        cell.btn_RoleChangeBtnRef.addTarget(self, action: #selector(RoleChangeButtonClicked), for: .touchUpInside)
        /* button for view Details */
        cell.btn_ViewRideDetailsRef.layer.cornerRadius = 5.0
        cell.btn_ViewRideDetailsRef.layer.masksToBounds = true
        cell.btn_ViewRideDetailsRef.tag = indexPath.row;
        cell.btn_ViewRideDetailsRef.addTarget(self, action: #selector(viewRideDetailsButtonClicked), for: .touchUpInside)
    cell.selectionStyle = .none

        
        return cell
    }
    
    @objc func viewRideDetailsButtonClicked(sender: UIButton) {
        self.str_SelectedRideID = ary_AcceptedFutureRideInfoRef[sender.tag].id ?? ""
        rideInfoDict = ary_AcceptedFutureRideInfoRef[sender.tag]
        self.driverOnlineAPI(withDriverLoginID: loginDriverIDStr, withOnOfflineStatus: "2")
    }
    
    @objc func RoleChangeButtonClicked(sender: UIButton) {
        self.str_SelectedRideID = ary_AcceptedFutureRideInfoRef[sender.tag].id ?? ""
        
        self.DriverRoleChangeAPI(withDriverLoginID: loginDriverIDStr, withRideId: str_SelectedRideID, withswipetype: "1")

    }
}
//MARK: - DriverOnlineAPI
extension AcceptedRidesInfoViewController {
    func driverOnlineAPI(withDriverLoginID: String, withOnOfflineStatus: String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverOnlineAPIServices(perams: ["driverid":DriverLoginID,"status":withOnOfflineStatus,"version":"yes"]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                    let Storyboard : UIStoryboard = UIStoryboard(name: "OngoingRides", bundle: nil)
                    let nxtVC = Storyboard.instantiateViewController(withIdentifier: "OngoingRideDetailsViewController") as! OngoingRideDetailsViewController
                    nxtVC.str_ComingFrom = str_SelectedType
                    nxtVC.str_SelectedRideID = str_SelectedRideID
                    nxtVC.dict_RideInfo = rideInfoDict
                    nxtVC.str_Dateandtime = str_dateandtime
                    self.navigationController?.pushViewController(nxtVC, animated:  true)
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
//MARK: - DriverRoleChangeAPI
extension AcceptedRidesInfoViewController {
    func DriverRoleChangeAPI(withDriverLoginID: String, withRideId: String, withswipetype: String ) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverRoleChangeAPIServices(perams: ["driverid":DriverLoginID,"ride_id":withRideId,"swap": withswipetype]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                    str_SelectedType = "Partner"
                    self.btn_DriverAcceptedFutureRideRef.backgroundColor = .gray
                    self.btn_PartnerAcceptedFutureRideRef.backgroundColor = .green

                    //API Calling....
                    self.partnerAcceptedFutureRideListAPI(withDriverLoginID:loginDriverIDStr)
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
//MARK: - DriverfutureRideListAPI
extension AcceptedRidesInfoViewController {
    func driverAcceptedFutureRideListAPI(withDriverLoginID: String ) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
         self.viewModel.requestForDriverAcceptedFutureRideListAPIServices(perams: ["driver_id":DriverLoginID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                    if let responseData = userData.data {
                        ary_AcceptedFutureRideInfoRef = responseData
                    }
                    var arr_DropDate:[String] = []
                    for response in ary_AcceptedFutureRideInfoRef {
                        let str_EstimatedSec = response.second ?? "0"
                        let str_FutureRidedate = response.otherdate ?? ""
                        let str_FutureRideTime = response.time ?? ""
                        let finalDate = str_FutureRidedate + " " + str_FutureRideTime
                        
                        let dateFormatterGet = DateFormatter()
                        dateFormatterGet.dateFormat = "MM-dd-yyyy hh:mm a"
                        guard let StartDate = dateFormatterGet.date(from: finalDate) else {return }
                        
                        let hoursToAdd = Int(str_EstimatedSec)
                        let gregorian = Calendar(identifier: .gregorian)
                        var comps = DateComponents()
                        comps.second = hoursToAdd
                        let EndDate = gregorian.date(byAdding: comps, to: StartDate)
                        var Str_DropOffDate_time: String = ""
                        if let str_EndDate = EndDate {
                            Str_DropOffDate_time = dateFormatterGet.string(from: str_EndDate)
                        }
                        arr_DropDate.append(Str_DropOffDate_time)
                    }
                    ary_FutureRideEstimatedDropDateRef = arr_DropDate
                    self.tableview_AcceptedFutureRideList.reloadData()
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
//MARK: - PartnerfutureRideListAPI
extension AcceptedRidesInfoViewController {
    func partnerAcceptedFutureRideListAPI(withDriverLoginID : String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
         self.viewModel.requestForpartnerAcceptedFutureRideListAPIServices(perams: ["driver_id":DriverLoginID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                    if let responseData = userData.data {
                        ary_AcceptedFutureRideInfoRef = responseData
                    }
                    var arr_DropDate:[String] = []
                    for response in ary_AcceptedFutureRideInfoRef {
                        let str_EstimatedSec = response.second ?? "0"
                        let str_FutureRidedate = response.otherdate ?? ""
                        let str_FutureRideTime = response.time ?? ""
                        let finalDate = str_FutureRidedate + " " + str_FutureRideTime
                        
                        let dateFormatterGet = DateFormatter()
                        dateFormatterGet.dateFormat = "MM-dd-yyyy hh:mm a"
                        guard let StartDate = dateFormatterGet.date(from: finalDate) else {return }
                        
                        let hoursToAdd = Int(str_EstimatedSec)
                        let gregorian = Calendar(identifier: .gregorian)
                        var comps = DateComponents()
                        comps.second = hoursToAdd
                        let EndDate = gregorian.date(byAdding: comps, to: StartDate)
                        var Str_DropOffDate_time: String = ""
                        if let str_EndDate = EndDate {
                            Str_DropOffDate_time = dateFormatterGet.string(from: str_EndDate)
                        }
                        arr_DropDate.append(Str_DropOffDate_time)
                    }
                    ary_FutureRideEstimatedDropDateRef = arr_DropDate
                    self.tableview_AcceptedFutureRideList.reloadData()
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
