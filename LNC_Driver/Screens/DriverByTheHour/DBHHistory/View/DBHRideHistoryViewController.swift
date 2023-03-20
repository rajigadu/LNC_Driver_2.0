//
//  DBHRideHistoryViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 19/03/23.
//

import UIKit

class DBHRideHistoryViewController: UIViewController {
    
    @IBOutlet weak var tableview_RideInfoRef: UITableView!
    @IBOutlet weak var lbl_NoListRef: UILabel!
    
    var ary_PaymentHistoryInfo: [DBHRideHistoryDatar] = []
    lazy var viewModel = {
        DBHRideHistoryViewModel()
    }()
    
    var loginDriverIDStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DBH - Ride History"
        self.swipeRight()
        self.tableview_RideInfoRef.estimatedRowHeight = 1000
        self.tableview_RideInfoRef.rowHeight = UITableView.automaticDimension

        loginDriverIDStr = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        self.lbl_NoListRef.isHidden = true
        
        self.rideListAPI()
    }
    
    @IBAction func openMenuBtnref(_ sender: Any) {
        self.navigateToSideMenu()
    }
    

}
extension DBHRideHistoryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView, ArrayCount: ary_PaymentHistoryInfo.count, numberOfsections: 1, data_MSG_Str: "No data available")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary_PaymentHistoryInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:DBHRideHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DBHRideHistoryTableViewCell", for: indexPath) as? DBHRideHistoryTableViewCell else {return UITableViewCell()}
        
        
        //Date / Time
        let str_CurrentRideDate = ary_PaymentHistoryInfo[indexPath.row].otherdate ?? ""
        let str_CurrentRideTime = ary_PaymentHistoryInfo[indexPath.row].time ?? ""
        let AttributeStr = "Ride Date : " + str_CurrentRideDate + " " + str_CurrentRideTime
        let attrStri = NSMutableAttributedString.init(string:AttributeStr)
        let nsRange = NSString(string: AttributeStr).range(of: "Ride Date :", options: String.CompareOptions.caseInsensitive)
        attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
        cell.lbl_JourneyDateRef.attributedText = attrStri
        
        //UserName // Pickup Address
        let str_Userlastname = ary_PaymentHistoryInfo[indexPath.row].last_name ?? ""
        let str_UserFirstname = ary_PaymentHistoryInfo[indexPath.row].first_name ?? ""
        let str_userFullname = str_UserFirstname + " " + str_Userlastname
        let pickUPAddress = ary_PaymentHistoryInfo[indexPath.row].pickup_address ?? ""
        let AttributeStr2 = "Customer Name : " + str_userFullname + " \n\nRide Start : " + pickUPAddress
        let attrStri2 = NSMutableAttributedString.init(string:AttributeStr2)
        var nsRange2 = NSString(string: AttributeStr2).range(of: "Customer Name : ", options: String.CompareOptions.caseInsensitive)
        attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange2)
        
        nsRange2 = NSString(string: AttributeStr2).range(of: "Ride Start : ", options: String.CompareOptions.caseInsensitive)
        attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange2)
        
        cell.lbl_RideInfoRef.attributedText = attrStri2


        
        // Total hrs
        
        let ride_total_time = ary_PaymentHistoryInfo[indexPath.row].ride_total_time ?? "00"
        let ride_total_minute = ary_PaymentHistoryInfo[indexPath.row].ride_total_minute ?? "00"
        
        let AttributeStr3 = "Ride Total Time : " + ride_total_time + " : " + ride_total_minute + " Hrs"
        let attrStri3 = NSMutableAttributedString.init(string:AttributeStr3)
        let nsRange3 = NSString(string: AttributeStr3).range(of: "Ride Total Time : ", options: String.CompareOptions.caseInsensitive)
        attrStri3.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange3)
        cell.lbl_DistanceRef.attributedText = attrStri3

        
        // Total Amount
        let hourly_rate_while_ride_completed = ary_PaymentHistoryInfo[indexPath.row].hourly_rate_while_ride_completed ?? ""
        let AttributeStr4 = "Hourly Rate: " + hourly_rate_while_ride_completed + "/Hrs"
        let attrStri4 = NSMutableAttributedString.init(string:AttributeStr4)
        let nsRange4 = NSString(string: AttributeStr4).range(of: "Hourly Rate:", options: String.CompareOptions.caseInsensitive)
        attrStri4.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange4)
        cell.NumbAdditionalstopsRef.attributedText = attrStri4

        cell.selectionStyle = .none
        return cell
    }
    
}
extension DBHRideHistoryViewController {
    
    //MARK: - DBH Ride Payment Details
    func rideListAPI() {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDBHRideHistoryServices(perams: ["driver_id":DriverLoginID]) { success, model, error in
            if success, let RideHistoryUserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    
                    if RideHistoryUserData.status == "1" {
                        if let data = RideHistoryUserData.data {
                            self.ary_PaymentHistoryInfo = data
                        }
    //                    self.ary_PaymentHistoryInfo.reverse()
                        self.tableview_RideInfoRef.reloadData()

                    } else {
                        self.showToast(message: I18n.NoRecordFound, font: .systemFont(ofSize: 12.0))
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



