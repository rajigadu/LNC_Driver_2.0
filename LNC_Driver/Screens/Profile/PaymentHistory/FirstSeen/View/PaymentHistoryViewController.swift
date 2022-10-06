//
//  PaymentHistoryViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import UIKit

class PaymentHistoryViewController: UIViewController {

    @IBOutlet weak var lbl_NoReacordFoundRef: UILabel!
    @IBOutlet weak var tableview_PaymentHistoryRef: UITableView!
    
    var ary_PaymentHistoryInfo: [PaymentHistoryDatar] = []
    lazy var viewModel = {
        PaymentHistoryViewModel()
    }()
    
    var loginDriverIDStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Payment History"
        
        self.tableview_PaymentHistoryRef.estimatedRowHeight = 1000
        self.tableview_PaymentHistoryRef.rowHeight = UITableView.automaticDimension
        
        loginDriverIDStr = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        self.lbl_NoReacordFoundRef.isHidden = true
        
        self.paymentHistoryAPI()
        // Do any additional setup after loading the view.
    }

    @IBAction func menuOpenBtnref(_ sender: Any) {
        self.navigateToSideMenu()
    }
}
extension PaymentHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView, ArrayCount: self.ary_PaymentHistoryInfo.count, numberOfsections: 1, data_MSG_Str: "no record found")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.ary_PaymentHistoryInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:PaymentHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PaymentHistoryTableViewCell", for: indexPath) as? PaymentHistoryTableViewCell else {return UITableViewCell()}
        
        //Date and time
        let str_CurrentRideDateTime = self.ary_PaymentHistoryInfo[indexPath.row].otherdate ?? ""
        let str_CurrentRideTime = self.ary_PaymentHistoryInfo[indexPath.row].time ?? ""
        
        let AttributeStr = "Date|Time : " + str_CurrentRideDateTime + " " + str_CurrentRideTime
        let attrStri = NSMutableAttributedString.init(string:AttributeStr)
        let nsRange = NSString(string: AttributeStr).range(of: "Date|Time :", options: String.CompareOptions.caseInsensitive)
        attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
        cell.lbl_DateRef.attributedText = attrStri

        // strtlocation*************
        let rideStartLocation = self.ary_PaymentHistoryInfo[indexPath.row].pickup_address ?? ""
        let rideEndLocation = self.ary_PaymentHistoryInfo[indexPath.row].drop_address ?? ""
        let DriverFirstname = self.ary_PaymentHistoryInfo[indexPath.row].first_name ?? ""
        let Driverlastname = self.ary_PaymentHistoryInfo[indexPath.row].last_name ?? ""
        let str_RideId = self.ary_PaymentHistoryInfo[indexPath.row].booking_id ?? "0"
        var str_ride_amt = self.ary_PaymentHistoryInfo[indexPath.row].ride_amt ?? "0.00"
        var str_drivers_amount = self.ary_PaymentHistoryInfo[indexPath.row].drivers_amount ?? "0.00"
        var str_partners_amount = self.ary_PaymentHistoryInfo[indexPath.row].partners_amount ?? "0.00"
        let str_WaitingTime = self.ary_PaymentHistoryInfo[indexPath.row].unplaned_waiting_time ?? ""
        let str_waitingTimeAmount = self.ary_PaymentHistoryInfo[indexPath.row].unplaned_waiting_amt ?? ""
        let str_plannedStopsCount = self.ary_PaymentHistoryInfo[indexPath.row].planed_stop_count ?? ""
        let str_plannedStopsAmount = self.ary_PaymentHistoryInfo[indexPath.row].planed_stop_amt ?? ""
        let str_UnplannedStopsCount = self.ary_PaymentHistoryInfo[indexPath.row].unplaned_stop_count ?? ""
        let str_UnplannedStopsAmount = self.ary_PaymentHistoryInfo[indexPath.row].unplaned_stop_amt ?? ""
        var str_partnerbase_price = self.ary_PaymentHistoryInfo[indexPath.row].base_price ?? "0.00"
        var str_partner_base_share = self.ary_PaymentHistoryInfo[indexPath.row].partner_base_share ?? "0.00"
        var str_partner_unplanned_stop_amount = self.ary_PaymentHistoryInfo[indexPath.row].partner_unplanned_stop_amount ?? "0"
        let str_partner_planned_stop_amount = self.ary_PaymentHistoryInfo[indexPath.row].partner_planned_stop_amount ?? "0"
        let str_partner_unplanned_waiting_time = self.ary_PaymentHistoryInfo[indexPath.row].partner_unplanned_waiting_time ?? "0"
        
        var str_driver_base_price = self.ary_PaymentHistoryInfo[indexPath.row].base_price ?? "0.00"
        var str_driver_base_share = self.ary_PaymentHistoryInfo[indexPath.row].driver_base_share ?? "0.00"
        let str_driver_unplanned_stop_amount = self.ary_PaymentHistoryInfo[indexPath.row].driver_unplanned_stop_amount ?? "0"
        let str_driver_planned_stop_amount = self.ary_PaymentHistoryInfo[indexPath.row].driver_planned_stop_amount ?? "0"
        let str_driver_unplanned_waiting_time = self.ary_PaymentHistoryInfo[indexPath.row].driver_unplanned_waiting_time ?? "0"
        
        var Str_DriverTOTALPAY = ""
        var Str_parnerTOTALPAY = ""
        
        let str_CurrentRideUsername = DriverFirstname + " " + Driverlastname
        
        let AttributeStr2 = "Customer Name : " + DriverFirstname + " " + Driverlastname
        let attrStri2 = NSMutableAttributedString.init(string:AttributeStr2)
        let nsRange2 = NSString(string: AttributeStr2).range(of: "Customer Name :", options: String.CompareOptions.caseInsensitive)
        attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange2)
        cell.lbl_RideInfoRef.attributedText = attrStri2
        
        if str_driver_base_price == "0.00" {
            if str_ride_amt == "0.00" {
                str_ride_amt = "0"
            } else {
                str_driver_base_price = str_ride_amt
            }
        }
        
        //str_driver_base_share
        if str_driver_base_share == "0.00" {
            if str_drivers_amount == "0.00" {
                str_drivers_amount = "0"
            } else {
                str_driver_base_share = str_drivers_amount
            }
        }
        
        //********Partner Details//////
        //str_partnerbase_price
        if str_partnerbase_price == "0.00" {
            if str_ride_amt == "0.00" {
                str_ride_amt = "0"
            } else {
                str_partnerbase_price = str_ride_amt
            }
        }
        
        //str_partner_base_share
        if str_partner_base_share == "0.00" {
            if str_partners_amount == "0.00" {
                str_partners_amount = "0"
            } else {
                str_partner_base_share = str_partners_amount
            }
        }
        
        var str_RidedriverID = self.ary_PaymentHistoryInfo[indexPath.row].driver_id_for_future_ride ?? ""
        var str_RidePartnerID = self.ary_PaymentHistoryInfo[indexPath.row].future_partner_id ?? ""
        //Mark: Login Driver and Ride Driver Same
        if str_RidedriverID == loginDriverIDStr {
            var str_drivers_tip = self.ary_PaymentHistoryInfo[indexPath.row].drivers_tip ?? "0"
            var str_driver_share = self.ary_PaymentHistoryInfo[indexPath.row].driver_share ?? "0.00"
            var str_drivers_amount = self.ary_PaymentHistoryInfo[indexPath.row].drivers_amount ?? ""
            //partners_tip
              //Driver Tip Amount
            if str_driver_share == "0.00" {
                if str_drivers_amount == "0.00" {
                    str_drivers_amount = "0"
                } else {
                    let total = (Float(str_drivers_tip ?? "0") ?? 0.00) + (Float(str_drivers_amount ?? "0") ?? 0.00)
                    Str_DriverTOTALPAY = String(total)
                }
            } else {
                let total = (Float(str_drivers_tip ?? "0") ?? 0.00) + (Float(str_drivers_amount ?? "0") ?? 0.00)
                Str_DriverTOTALPAY = String(total)
            }
            
            //Driver Share
            if str_drivers_amount == "0.00" {
                str_drivers_amount = "0"
            } else {
                let total = (Float(str_drivers_tip ?? "0") ?? 0.00) + (Float(str_drivers_amount ?? "0") ?? 0.00)
                Str_DriverTOTALPAY = String(total)
            }
            
            
            
            
            let AttributeStr3 = "Ride Id : " + str_RideId + "\n\nDriver Pay Summary\n\n==============\n\n\nBase Fare : $" + str_driver_base_price + "\n\nDrivers Pay : $" + str_driver_base_share + "\n\nUnplanned Stops : $" + str_driver_unplanned_stop_amount + "\n\nPlanned-Stops : $" + str_driver_planned_stop_amount + "\n\nWait time : $" + str_driver_unplanned_waiting_time + "\n\nTip Amount : $" + str_drivers_tip + "\n\nTOTAL PAY : $" + Str_DriverTOTALPAY
            
            
            let attrStri3 = NSMutableAttributedString.init(string:AttributeStr3)
            
            var nsRange3 = NSString(string: AttributeStr3).range(of: "Ride Id :", options: String.CompareOptions.caseInsensitive)
            attrStri3.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange3)
            
             nsRange3 = NSString(string: AttributeStr3).range(of: "Driver Pay Summary", options: String.CompareOptions.caseInsensitive)
            attrStri3.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], range: nsRange3)

             nsRange3 = NSString(string: AttributeStr3).range(of: "==============", options: String.CompareOptions.caseInsensitive)
            attrStri3.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], range: nsRange3)

             nsRange3 = NSString(string: AttributeStr3).range(of: "Base Fare :", options: String.CompareOptions.caseInsensitive)
            attrStri3.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange3)

             nsRange3 = NSString(string: AttributeStr3).range(of: "Drivers Pay :", options: String.CompareOptions.caseInsensitive)
            attrStri3.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange3)

             nsRange3 = NSString(string: AttributeStr3).range(of: "Unplanned Stops :", options: String.CompareOptions.caseInsensitive)
            attrStri3.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange3)

             nsRange3 = NSString(string: AttributeStr3).range(of: "Planned-Stops :", options: String.CompareOptions.caseInsensitive)
            attrStri3.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange3)

             nsRange3 = NSString(string: AttributeStr3).range(of: "Wait time :", options: String.CompareOptions.caseInsensitive)
            attrStri3.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange3)

             nsRange3 = NSString(string: AttributeStr3).range(of: "Tip Amount :", options: String.CompareOptions.caseInsensitive)
            attrStri3.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange3)

             nsRange3 = NSString(string: AttributeStr3).range(of: "TOTAL PAY :", options: String.CompareOptions.caseInsensitive)
            attrStri3.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange3)

            cell.lbl_PaymentIDRef.attributedText = attrStri3

            cell.lbl_AmountRef.isHidden = true
            cell.btn_SelfPartnerPaymentRef.tag = indexPath.row
            cell.btn_SelfPartnerPaymentRef.addTarget(self, action: #selector(selfPartnerPayment), for: .touchUpInside)
            
        }
        //Mark: Login Driver and Ride Partner Same
        else if str_RidePartnerID == loginDriverIDStr {
            var str_partner_share = self.ary_PaymentHistoryInfo[indexPath.row].partner_share ?? "0.00"
            var str_partners_tip = self.ary_PaymentHistoryInfo[indexPath.row].partners_tip ?? "0"
            var str_partners_amount = self.ary_PaymentHistoryInfo[indexPath.row].partners_amount ?? ""
            
            if str_partner_share == "0.00" {
                if str_partners_amount == "0.00" {
                    str_partners_amount = "0"
                } else {
                    str_partner_share = "0"
                    
                    let total = (Float(str_partners_tip ?? "0") ?? 0.00) + (Float(str_partners_amount ?? "0") ?? 0.00)
                    Str_parnerTOTALPAY = String(total)
                }
            }else {
                let total = (Float(str_partners_tip ?? "0") ?? 0.00) + (Float(str_partner_share ?? "0") ?? 0.00)
                Str_parnerTOTALPAY = String(total)
            }
            
            let AttributeStr4 = "Ride Id : " + str_RideId + "\n\nFollower Pay Summary\n\n==============\n\n\nBase Fare : $" + str_partnerbase_price + "\n\nDrivers Pay : $" + str_partner_base_share + "\n\nUnplanned Stops : $" + str_partner_unplanned_stop_amount + "\n\nPlanned-Stops : $" + str_partner_planned_stop_amount + "\n\nWait time : $" + str_partner_unplanned_waiting_time + "\n\nTip Amount : $" + str_partners_tip + "\n\nTOTAL PAY : $" + Str_parnerTOTALPAY
            
            let attrStri4 = NSMutableAttributedString.init(string:AttributeStr4)
            
            var nsRange4 = NSString(string: AttributeStr4).range(of: "Ride Id :", options: String.CompareOptions.caseInsensitive)
            attrStri4.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange4)
            
             nsRange4 = NSString(string: AttributeStr4).range(of: "Follower Pay Summary", options: String.CompareOptions.caseInsensitive)
            attrStri4.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], range: nsRange4)

             nsRange4 = NSString(string: AttributeStr4).range(of: "==============", options: String.CompareOptions.caseInsensitive)
            attrStri4.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], range: nsRange4)

             nsRange4 = NSString(string: AttributeStr4).range(of: "Base Fare :", options: String.CompareOptions.caseInsensitive)
            attrStri4.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange4)

             nsRange4 = NSString(string: AttributeStr4).range(of: "Drivers Pay :", options: String.CompareOptions.caseInsensitive)
            attrStri4.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange4)

             nsRange4 = NSString(string: AttributeStr4).range(of: "Unplanned Stops :", options: String.CompareOptions.caseInsensitive)
            attrStri4.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange4)

             nsRange4 = NSString(string: AttributeStr4).range(of: "Planned-Stops :", options: String.CompareOptions.caseInsensitive)
            attrStri4.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange4)

             nsRange4 = NSString(string: AttributeStr4).range(of: "Wait time :", options: String.CompareOptions.caseInsensitive)
            attrStri4.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange4)

             nsRange4 = NSString(string: AttributeStr4).range(of: "Tip Amount :", options: String.CompareOptions.caseInsensitive)
            attrStri4.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange4)

             nsRange4 = NSString(string: AttributeStr4).range(of: "TOTAL PAY :", options: String.CompareOptions.caseInsensitive)
            attrStri4.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange4)

            cell.lbl_PaymentIDRef.attributedText = attrStri4
            cell.lbl_AmountRef.isHidden = true
            cell.btn_SelfPartnerPaymentRef.tag = indexPath.row
            cell.btn_SelfPartnerPaymentRef.addTarget(self, action: #selector(selfPartnerPayment), for: .touchUpInside)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func selfPartnerPayment(sender: UIButton) {
        let Storyboard : UIStoryboard = UIStoryboard(name: "RidesHistory", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "SelfPartnerDetailsViewController") as! SelfPartnerDetailsViewController
        nxtVC.dict_RidePartnerDetails = self.ary_PaymentHistoryInfo[sender.tag]
        self.navigationController?.pushViewController(nxtVC, animated:  true)
    }
    
}

extension PaymentHistoryViewController {
    
    //MARK: - Week Payment Details
    func paymentHistoryAPI() {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForPaymentHistoryServices(perams: ["driverid":DriverLoginID]) { success, model, error in
            if success, let GetBankDetailsModel = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let data = GetBankDetailsModel.data {
                        self.ary_PaymentHistoryInfo = data
                    }
//                    self.ary_PaymentHistoryInfo.reverse()
                    self.tableview_PaymentHistoryRef.reloadData()
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



