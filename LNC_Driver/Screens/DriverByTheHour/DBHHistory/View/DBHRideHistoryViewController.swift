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
        
        //self.rideListAPI()
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
        let AttributeStr2 = "Customer Name : " + str_userFullname + " \n\n Ride Start : " + pickUPAddress
        let attrStri2 = NSMutableAttributedString.init(string:AttributeStr2)
        var nsRange2 = NSString(string: AttributeStr2).range(of: "Custumer Name :", options: String.CompareOptions.caseInsensitive)
        attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange2)
        
        nsRange2 = NSString(string: AttributeStr2).range(of: "Ride Start :", options: String.CompareOptions.caseInsensitive)
        attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange2)
        
        cell.lbl_RideInfoRef.attributedText = attrStri2


        
        // Total hrs
        
        let str_Distance = ary_PaymentHistoryInfo[indexPath.row].distance ?? "0.00"
        let distanceinFloat = Float(str_Distance)
        
        let AttributeStr3 = "Distance : " + str_Distance + " Miles"
        let attrStri3 = NSMutableAttributedString.init(string:AttributeStr3)
        let nsRange3 = NSString(string: AttributeStr3).range(of: "Distance :", options: String.CompareOptions.caseInsensitive)
        attrStri3.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange3)
        cell.lbl_DistanceRef.attributedText = attrStri3

        
        // Total Amount
        let str_noaddtionastops = ary_PaymentHistoryInfo[indexPath.row].unplanned_stops ?? ""
        let AttributeStr4 = "Number Of Additional Stops : " + str_noaddtionastops
        let attrStri4 = NSMutableAttributedString.init(string:AttributeStr4)
        let nsRange4 = NSString(string: AttributeStr4).range(of: "Number Of Additional Stops:", options: String.CompareOptions.caseInsensitive)
        attrStri4.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange4)
        cell.NumbAdditionalstopsRef.attributedText = attrStri4

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard : UIStoryboard = UIStoryboard(name: "RidesHistory", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "ShowRideLocationViewController") as! ShowRideLocationViewController
        nxtVC.ridePickUPLat = ary_PaymentHistoryInfo[indexPath.row].pickup_lat ?? ""
        nxtVC.ridePickUPLong = ary_PaymentHistoryInfo[indexPath.row].pickup_long ?? ""
        nxtVC.rideDropLat = ary_PaymentHistoryInfo[indexPath.row].d_lat ?? ""
        nxtVC.rideDropLong = ary_PaymentHistoryInfo[indexPath.row].d_long ?? ""
        nxtVC.rideDistance = ary_PaymentHistoryInfo[indexPath.row].distance ?? ""
        self.navigationController?.pushViewController(nxtVC, animated: true)
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



