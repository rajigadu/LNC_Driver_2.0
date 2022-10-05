//
//  WeekRideinfoViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import UIKit

class WeekRideinfoViewController: UIViewController {

    @IBOutlet weak var lbl_NoReacordFoundRef: UILabel!
    @IBOutlet weak var tableview_PaymentHistoryRef: UITableView!
    
    var str_Todates = ""
    var str_Fromdate = ""
    var loginDriverIDStr = ""
    var ary_WeekRideinfoHistory: [WeekRideinfoDatar] = []
    lazy var viewModel = {
        WeekRideinfoViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "WEEK RIDE INFO"
        self.loginDriverIDStr = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        self.tableview_PaymentHistoryRef.rowHeight = UITableView.automaticDimension
        self.lbl_NoReacordFoundRef.isHidden = true
        // Do any additional setup after loading the view.
        if str_Todates != "" || str_Fromdate != ""{
            self.WeeklyRideinfoAPI()
        }
    }

}
extension WeekRideinfoViewController: UITableViewDelegate,UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 123
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView, ArrayCount: self.ary_WeekRideinfoHistory.count, numberOfsections: 1, data_MSG_Str: "no record found")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.ary_WeekRideinfoHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:WeekrideinfoCell = tableView.dequeueReusableCell(withIdentifier: "WeekrideinfoCell", for: indexPath) as? WeekrideinfoCell else {return UITableViewCell()}
        
        // Name
        var Str_UserName = ""
        if let str_userFirstname = self.ary_WeekRideinfoHistory[indexPath.row].first_name, let str_last_name = self.ary_WeekRideinfoHistory[indexPath.row].last_name {
            Str_UserName = str_userFirstname + " " + str_last_name
        } else {
            Str_UserName = ""
        }
        //Date / Time
        var Str_OriginalFromdate_time = ""
        
        if let str_fromDate = self.ary_WeekRideinfoHistory[indexPath.row].otherdate, let str_toDate = self.ary_WeekRideinfoHistory[indexPath.row].time,str_fromDate != "" || str_toDate != "" {
            Str_OriginalFromdate_time = str_fromDate + " " + str_toDate
        }
        
        // str date and time
        if Str_OriginalFromdate_time != "" {
            let AttributeStr = "Ride Date/Time : " + Str_OriginalFromdate_time + "\nUser Name : " + Str_UserName
            let attrStri = NSMutableAttributedString.init(string:AttributeStr)
            var nsRange = NSString(string: AttributeStr).range(of: "Ride Date/Time :", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
            nsRange = NSString(string: AttributeStr).range(of: "User Name :", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
            cell.lbl_DateRef.attributedText = attrStri
        }
        
        //// str ride location
        var rideStartLocation = ""
        var rideEndLocation = ""
        if let startLocation = self.ary_WeekRideinfoHistory[indexPath.row].pickup_address, let endLocation = self.ary_WeekRideinfoHistory[indexPath.row].drop_address,startLocation != "" || endLocation != "" {
            rideStartLocation = startLocation
            rideEndLocation = endLocation
        } else {
            rideStartLocation = ""
            rideEndLocation = ""
        }
        
        // str ride location
        if rideStartLocation != "" || rideEndLocation != "" {
            let AttributeStr = "Pickup Location : " + rideStartLocation + "\nDrop Location : " + rideEndLocation
            let attrStri = NSMutableAttributedString.init(string:AttributeStr)
            var nsRange = NSString(string: AttributeStr).range(of: "Pickup Location :", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
            nsRange = NSString(string: AttributeStr).range(of: "Drop Location :", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
            cell.lbl_RideInfoRef.attributedText = attrStri
        }
        ////total tip amt
        var totaltip = self.ary_WeekRideinfoHistory[indexPath.row].total_tip_amount ?? ""
        if totaltip != "" {
            let AttributeStr = "Total Tip Amount: " + totaltip
            let attrStri = NSMutableAttributedString.init(string:AttributeStr)
            var nsRange = NSString(string: AttributeStr).range(of: "Total Tip Amount:", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
            nsRange = NSString(string: AttributeStr).range(of: "PAYMENT FAILED", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], range: nsRange)
            cell.lbl_PaymentIDRef.attributedText = attrStri
        }

        //Driver ID
        let str_RidedriverID = self.ary_WeekRideinfoHistory[indexPath.row].driver_id ?? ""
        if loginDriverIDStr == str_RidedriverID {
            //str_driver_status
            let str_driver_status =  self.ary_WeekRideinfoHistory[indexPath.row].driver_status ?? ""
            
            if str_driver_status == "" {
                cell.btn_SelfPartnerPaymentRef.isHidden = true
            } else if str_driver_status == "self" {
                cell.btn_SelfPartnerPaymentRef.isHidden = false
                let AttributeStr = "Partner : " + str_driver_status
                let attrStri = NSMutableAttributedString.init(string:AttributeStr)
                let nsRange = NSString(string: AttributeStr).range(of: "Partner :", options: String.CompareOptions.caseInsensitive)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
                cell.lbl_AmountRef.attributedText = attrStri
                cell.btn_SelfPartnerPaymentRef.tag = indexPath.row
                cell.btn_SelfPartnerPaymentRef.addTarget(self, action: #selector(selfPartnerPayment), for: .touchUpInside)
            } else {
                cell.btn_SelfPartnerPaymentRef.isHidden = true
                let str_PartnerAmount = "$ " + (self.ary_WeekRideinfoHistory[indexPath.row].drivers_amount ?? "0") ?? ""
                let str_PartnerTip = "$ " + (self.ary_WeekRideinfoHistory[indexPath.row].drivers_tip ?? "0") ?? ""
                
                let AttributeStr = "Driver Amount: " + str_PartnerAmount + "\nDriver Tip:" + str_PartnerTip
                let attrStri = NSMutableAttributedString.init(string:AttributeStr)
                var nsRange = NSString(string: AttributeStr).range(of: "Driver Amount:", options: String.CompareOptions.caseInsensitive)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
                nsRange = NSString(string: AttributeStr).range(of: "Driver Tip:", options: String.CompareOptions.caseInsensitive)
                attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
                cell.lbl_AmountRef.attributedText = attrStri
            }
        } else {
            cell.btn_SelfPartnerPaymentRef.isHidden = true
            
            let str_PartnerAmount = "$ " + (self.ary_WeekRideinfoHistory[indexPath.row].partners_amount ?? "0") ?? ""
            let str_PartnerTip = "$ " + (self.ary_WeekRideinfoHistory[indexPath.row].partners_tip ?? "0") ?? ""
            
            let AttributeStr = "Partner Amount : " + str_PartnerAmount + "\nPartner Tip :" + str_PartnerTip
            let attrStri = NSMutableAttributedString.init(string:AttributeStr)
            var nsRange = NSString(string: AttributeStr).range(of: "Partner Amount :", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
            nsRange = NSString(string: AttributeStr).range(of: "Partner Tip :", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
            cell.lbl_AmountRef.attributedText = attrStri

        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // self.
    }
    
    @objc func selfPartnerPayment(sender: UIButton) {
        
    }
}


extension WeekRideinfoViewController {
    func WeeklyRideinfoAPI(){
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForWeekRideinfoServices(perams: ["driver_id":DriverLoginID,"to_week": self.str_Todates,"from_week":self.str_Fromdate]) { success, model, error in
            if success, let GetBankDetailsModel = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let data = GetBankDetailsModel.data {
                        self.ary_WeekRideinfoHistory = data
                    }
                    self.ary_WeekRideinfoHistory.reverse()
                    self.tableview_PaymentHistoryRef.reloadData()
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
