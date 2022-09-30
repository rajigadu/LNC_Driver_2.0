//
//  RideReservationsViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 30/09/22.
//

import UIKit

class RideReservationsViewController: UIViewController {
    
    @IBOutlet weak var btn_DriverRequestRef: UIButton!
    @IBOutlet weak var btn_PartnerRequestRef: UIButton!
    @IBOutlet weak var tableview_FutureRideList: UITableView!
    @IBOutlet weak var lbl_NoFutureRideFound: UILabel!

    var loginDriverIDStr = ""
    var str_SelectedType = ""
    var conditionstatus = ""
    
    var ary_FutureRideInfoRef: [RideReservationsDatar] = []
    var ary_FutureRideEstimatedDropDateRef: [String] = []

    
//    var ary_FutureRideInfo_DriverRef : [RideReservationsDatar] = []
//    var ary_AlreadyFutureRideAcceptedInfoRef : [AlereadyAcceptedridetimebasesDatar] = []
    
    var ary_FutureRidePickDateRef :[Date] = []
    var ary_FutureRideDropdateRef:[Date] = []
    
    
    var ary_FutureRidePickStartDate_PartnerRef :[Date] = []
    var ary_FutureRidePickDropDate_PartnerRef:[Date] = []
    
    var ary_AlreadyFutureRideAcceptedInfoRef : [AlereadyAcceptedridetimebasesDatar] = []


//    var ary_FutureRideInfo_PartnerRef:  [] = []
//    var ary_FutureRideInfo_PartnerTimeBasesRef : [] = []
    
//    var ary_FutureRideInfo_PartnerRef : [RideReservationsDatar] = []
//    var ary_AlreadyFutureRideAcceptedInfo_PartnerRef : [AlereadyAcceptedridetimebasesDatar] = []
//    var ary_FutureRideEstimatedDropDate_PartnerRef: [String] = []
    
   
    
    var str_SelectedRideID = ""

    lazy var viewModel = {
        RideReservationsViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conditionstatus = "No"
        self.title = "Ride Reservations"
        self.btn_DriverRequestRef.tag = 100;
        self.btn_PartnerRequestRef.tag = 101;
        self.tableview_FutureRideList.estimatedRowHeight = 1000;
        self.tableview_FutureRideList.rowHeight = UITableView.automaticDimension
        loginDriverIDStr = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        self.lbl_NoFutureRideFound.isHidden = true
//        self.tableview_FutureRideList.isHidden = true
        
        str_SelectedType = "Driver"
        self.btn_DriverRequestRef.backgroundColor = .green
        self.btn_PartnerRequestRef.backgroundColor = .gray
        self.driverfutureRideListAPI(withDriverLoginID : loginDriverIDStr)
    }
    

    @IBAction func btn_DriverPartnerRequestAction(_ sender: UIButton) {
        self.btn_DriverRequestRef.backgroundColor = .gray
        self.btn_PartnerRequestRef.backgroundColor = .gray
        
        switch sender.tag {
        case 100:
            str_SelectedType = "Driver"
            self.btn_DriverRequestRef.backgroundColor = .green
            self.btn_PartnerRequestRef.backgroundColor = .gray
            
            self.ary_FutureRideInfoRef.removeAll()
            self.ary_FutureRideEstimatedDropDateRef.removeAll()
            self.ary_FutureRidePickDateRef.removeAll()
            self.ary_FutureRideDropdateRef.removeAll()
            self.ary_AlreadyFutureRideAcceptedInfoRef.removeAll()
            
            self.tableview_FutureRideList.reloadData()
            
            self.driverfutureRideListAPI(withDriverLoginID : loginDriverIDStr)
            break
        case 101:
            str_SelectedType = "Partner"
            self.btn_DriverRequestRef.backgroundColor = .gray
            self.btn_PartnerRequestRef.backgroundColor = .green
            
            self.ary_FutureRideInfoRef.removeAll()
            self.ary_FutureRideEstimatedDropDateRef.removeAll()
            self.ary_FutureRidePickStartDate_PartnerRef.removeAll()
            self.ary_FutureRidePickDropDate_PartnerRef.removeAll()
            self.ary_AlreadyFutureRideAcceptedInfoRef.removeAll()

            self.tableview_FutureRideList.reloadData()
            
            self.partnerfutureRideListAPI(withDriverLoginID: loginDriverIDStr)
            break
        default:
            print("")
        }
    }
}
extension RideReservationsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
            return numberOfSections_nodata(in: tableView, ArrayCount: ary_FutureRideInfoRef.count, numberOfsections: 1, data_MSG_Str: "No records found!")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ary_FutureRideInfoRef.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FutureRideListVCTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FutureRideListVCTableViewCell", for: indexPath) as? FutureRideListVCTableViewCell else {return UITableViewCell()}
            /* Date */
            var str_FutureRidedate = ary_FutureRideInfoRef[indexPath.row].otherdate ?? ""
            /*Time */
            var str_FutureRideTime = ary_FutureRideInfoRef[indexPath.row].time ?? ""
            /*Estimation Time */
            var str_FutureRideEstimationDropTime = ary_FutureRideInfoRef[indexPath.row].estimation_time ?? ""
            //
            var str_FutureRideEstimationDropDate_Time = ""
            
            if ary_FutureRideEstimatedDropDateRef.count == ary_FutureRideInfoRef.count {
                str_FutureRideEstimationDropDate_Time = ary_FutureRideEstimatedDropDateRef[indexPath.row]
            }
            
            //
            var str_dateandtime = str_FutureRidedate + " " + str_FutureRideTime
            
            //Notes
            var str_notes = ary_FutureRideInfoRef[indexPath.row].notes ?? ""
            // str_Distance
            var str_Distance = ary_FutureRideInfoRef[indexPath.row].distance ?? ""
            let distanceFloat = Float(str_Distance) ?? 0.00
        // pickup Address
            var str_pickupAddress = ary_FutureRideInfoRef[indexPath.row].pickup_address ?? ""
        // Drop Address
        var str_dropAddress = ary_FutureRideInfoRef[indexPath.row].drop_address ?? ""
            
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
            

        cell.btn_AcceptRideRef.layer.cornerRadius = 5.0
        cell.btn_AcceptRideRef.layer.masksToBounds = true
        cell.btn_AcceptRideRef.tag = indexPath.row;
        cell.btn_AcceptRideRef.addTarget(self, action: #selector(AcceptedRideDetailsButtonClicked), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func AcceptedRideDetailsButtonClicked(sender: UIButton) {
        self.str_SelectedRideID = ary_FutureRideInfoRef[sender.tag].id ?? ""
        let str_FutureRidedate = ary_FutureRideInfoRef[sender.tag].otherdate ?? ""
        let str_FutureRideTime = ary_FutureRideInfoRef[sender.tag].time ?? ""
        
        let finalDate = str_FutureRidedate + " " + str_FutureRideTime
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM-dd-yyyy hh:mm a"
        guard let NewUpComingRide = dateFormatterGet.date(from: finalDate) else {return }
        
        if ary_FutureRideDropdateRef.count > 0 || ary_FutureRideDropdateRef.count == ary_FutureRidePickDateRef.count {
            for i in 0..<ary_FutureRideDropdateRef.count - 1 {
                let Str_EndDate  = ary_FutureRideDropdateRef[i]
                let Str_StartDate = ary_FutureRidePickDateRef[i]
                
                if NewUpComingRide.isBetween(startDate:Str_StartDate, endDate:Str_EndDate)  {
                    conditionstatus = "yes"
                    self.ShowAlert(message: "You have already another ride on same time")
                    break
                } else {
                    conditionstatus = "No"
                }
//
            }
        }
        
        
        if conditionstatus == "No" {
            if ary_FutureRidePickStartDate_PartnerRef.count > 0 || ary_FutureRidePickStartDate_PartnerRef.count == ary_FutureRidePickDropDate_PartnerRef.count {
                
                for i in 0..<ary_FutureRidePickStartDate_PartnerRef.count {
                    let Str_EndDate  = ary_FutureRidePickStartDate_PartnerRef[i]
                    let Str_StartDate = ary_FutureRidePickDropDate_PartnerRef[i]
                    
                    if NewUpComingRide.isBetween(startDate:Str_StartDate, endDate:Str_EndDate)  {
                        conditionstatus = "yes"
                        self.ShowAlert(message: "You have already another ride on same time")
                        break
                    } else {
                        conditionstatus = "No"
                    }
                }
            }
        }
        
        if conditionstatus == "No" {
            if str_SelectedType == "Driver" {
                self.driverAcceptFutureRideAPI(withDriverLoginID: loginDriverIDStr, withRideID: str_SelectedRideID, withProgramIdDriver: "")
            } else {
                self.partnerAcceptFutureRideAPI(withDriverLoginID: loginDriverIDStr, withRideID: str_SelectedRideID, withProgramIdDriver: "")
            }
        }

    }
    
    func isDate(_ date: Date, inRangeFirstDate firstDate: Date, last lastDate: Date) -> Bool {
        return date.compare(firstDate) == .orderedDescending && date.compare(lastDate) == .orderedAscending
    }
    
    func check(_ dateToCheck: Date, starting startingDate: Date, end endDate: Date) -> Bool {
        var returnValue: Bool
        
        if startingDate.compare(endDate) == .orderedDescending {
            returnValue = dateToCheck.compare(endDate) == .orderedAscending && dateToCheck.compare(startingDate) == .orderedDescending
        } else if startingDate.compare(endDate) == .orderedAscending {
            returnValue = dateToCheck.compare(startingDate) == .orderedAscending && dateToCheck.compare(endDate) == .orderedDescending
        } else {
            returnValue = dateToCheck.compare(startingDate) == .orderedSame && dateToCheck.compare(endDate) == .orderedSame
        }
        return returnValue
    }
}
extension Date
{
    func isBetween(startDate:Date, endDate:Date)->Bool
    {
         return (startDate.compare(self) == .orderedAscending) && (endDate.compare(self) == .orderedDescending)
    }
    
//    if Str_StartDate.laterDate(NewUpComingRide) == NewUpComingRide && NewUpComingRide.laterDate(Str_EndDate) == Str_EndDate {
    //                    conditionstatus = "yes"
    //                }

}

//MARK: - DriverfutureRideListAPI
extension RideReservationsViewController {
    func driverfutureRideListAPI(withDriverLoginID: String ) {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestFordriverfutureRideListAPIServices(perams: ["driver_id":"255"]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let responseData = userData.data {
                        ary_FutureRideInfoRef = responseData
                    }
                    var arr_DropDate:[String] = []
                    for response in ary_FutureRideInfoRef {
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
                    self.driverfutureRideListAcceptedAPI(withDriverLoginID: self.loginDriverIDStr)
                    self.tableview_FutureRideList.reloadData()
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "No Such Email Address Found.", font: .systemFont(ofSize: 12.0))
                }
             }
        }
    }
}

//MARK: - PartnerfutureRideListAPI
extension RideReservationsViewController {
    func partnerfutureRideListAPI(withDriverLoginID: String) {
        
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForpartnerfutureRideListAPIServices(perams: ["driverid":"255"]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let responseData = userData.data {
                        ary_FutureRideInfoRef = responseData
                    }
                    var arr_DropDate:[String] = []
                    for response in ary_FutureRideInfoRef {
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
                    self.partnerAcceptedFutureRideAcceptedListAPI(withDriverLoginID: self.loginDriverIDStr)
                    self.tableview_FutureRideList.reloadData()
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "No Such Email Address Found.", font: .systemFont(ofSize: 12.0))
                }
             }
        }

    }
}

//MARK: -- DriverAcceptfutureRideAPI
extension RideReservationsViewController {
    func driverAcceptFutureRideAPI(withDriverLoginID: String, withRideID: String, withProgramIdDriver: String) {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestdriverAcceptFutureRideAPIServices(perams: ["driver_id":"255","ride_id":withRideID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.defaultstr == "yes" {
                       // self.ShowAlertWithPush(message: userData.message ?? "", className: "DriverAcceptedVC", storyBoard: "RidesHistory", Animation: true)--
                    } else {
                        let Storyboard : UIStoryboard = UIStoryboard(name: "RidesHistoy", bundle: nil)
                        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "DummyPartnerSelectForFutureViewController") as! DummyPartnerSelectForFutureViewController
                        nxtVC.str_SelectedFutureRideID = str_SelectedRideID
                        self.navigationController?.pushViewController(nxtVC, animated: true)
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "No Such Email Address Found.", font: .systemFont(ofSize: 12.0))
                }
             }
        }
    }
}

//MARK: - partnerAcceptfutureRideAPI
extension RideReservationsViewController {
    func partnerAcceptFutureRideAPI(withDriverLoginID: String, withRideID: String, withProgramIdDriver: String) {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        self.viewModel.requestForPartnerAcceptFutureRideAPIServices(perams: ["driver_id":"255","ride_id":withRideID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                      //  self.ShowAlertWithPush(message: userData.message ?? "", className: "DriverAcceptedVC", storyBoard: "RidesHistory", Animation: true)--
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "No Such Email Address Found.", font: .systemFont(ofSize: 12.0))
                }
             }
        }
    }
}

//MARK: -- Aleready Accepted ride time bases --showing accepted button as Driver
//MARK: -- DriverfutureRideAccepetedListAPI
//MARK: --  DriverfutureRideListAPI
extension RideReservationsViewController {
    func driverfutureRideListAcceptedAPI(withDriverLoginID: String) {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        self.viewModel.requestFordriverfutureRideListAcceptedAPIServices(perams: ["driver_id":"255"]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let responseData = userData.data {
                        self.ary_AlreadyFutureRideAcceptedInfoRef = responseData
                    }
                    
                    var arr_RidePickStartDate:[Date] = []
                    var arr_RidePickDropDate:[Date] = []
                    
                    for response in ary_AlreadyFutureRideAcceptedInfoRef {
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
                        guard let EndDate = gregorian.date(byAdding: comps, to: StartDate) else {return }
                        var Str_DropOffDate_time: String = ""
                        if let str_EndDate = EndDate as? Date {
                            Str_DropOffDate_time = dateFormatterGet.string(from: str_EndDate)
                        }
                        arr_RidePickStartDate.append(StartDate)
                        arr_RidePickDropDate.append(EndDate)
                    }
                    
                    ary_FutureRidePickDateRef = arr_RidePickStartDate
                    ary_FutureRideDropdateRef = arr_RidePickDropDate
                    self.partnerAcceptedFutureRideAcceptedListAPI(withDriverLoginID: self.loginDriverIDStr)
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "No Such Email Address Found.", font: .systemFont(ofSize: 12.0))
                }
             }
        }

    }
}

//MARK: -- Aleready Accepted ride time bases --showing accepted button as partner
//MARK: -- PartnerfutureRideAccepetedListAPI
extension RideReservationsViewController {
    func partnerAcceptedFutureRideAcceptedListAPI(withDriverLoginID: String) {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        self.viewModel.requestForpartnerAcceptedFutureRideAcceptedListAPIServices(perams: ["driver_id":"255"]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let responseData = userData.data {
                        self.ary_AlreadyFutureRideAcceptedInfoRef = responseData
                    }
                    
                    var arr_RidePickStartDate:[Date] = []
                    var arr_RidePickDropDate:[Date] = []
                    
                    for response in ary_AlreadyFutureRideAcceptedInfoRef {
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
                        guard let EndDate = gregorian.date(byAdding: comps, to: StartDate) else {return }
                        var Str_DropOffDate_time: String = ""
                        if let str_EndDate = EndDate as? Date {
                            Str_DropOffDate_time = dateFormatterGet.string(from: str_EndDate)
                        }
                        arr_RidePickStartDate.append(StartDate)
                        arr_RidePickDropDate.append(EndDate)
                    }
                    
                    ary_FutureRidePickStartDate_PartnerRef = arr_RidePickStartDate
                    ary_FutureRidePickDropDate_PartnerRef = arr_RidePickDropDate
                    
                    self.tableview_FutureRideList.reloadData()
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "No Such Email Address Found.", font: .systemFont(ofSize: 12.0))
                }
             }
        }
    }
}
