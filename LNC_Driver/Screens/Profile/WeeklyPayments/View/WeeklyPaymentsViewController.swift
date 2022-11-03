//
//  WeeklyPaymentsViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import UIKit

class WeeklyPaymentsViewController: UIViewController {

    @IBOutlet weak var lbl_NoReacordFoundRef: UILabel!
    @IBOutlet weak var tableview_PaymentHistoryRef: UITableView!
    
    var ary_PaymentHistoryInfo: [WeeklyPaymentsWeekDatar] = []
    lazy var viewModel = {
        WeeklyPaymentsViewModel()
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weekly Payment"
        self.getWeekPaymentDeatils()
        self.lbl_NoReacordFoundRef.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openMenuBtn(_ sender: Any) {
        self.navigateToSideMenu()
    }
    
}

extension WeeklyPaymentsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView, ArrayCount: self.ary_PaymentHistoryInfo.count, numberOfsections: 1, data_MSG_Str: "no record found")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.ary_PaymentHistoryInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:WeeklyPaymentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WeeklyPaymentsTableViewCell", for: indexPath) as? WeeklyPaymentsTableViewCell else {return UITableViewCell()}
        
        // Amount
        if let str_Amount = self.ary_PaymentHistoryInfo[indexPath.row].amount {
            let AttributeStr = "Total Fare : " + str_Amount
            let attrStri = NSMutableAttributedString.init(string:AttributeStr)
            var nsRange = NSString(string: AttributeStr).range(of: "Total Fare :", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
            cell.lbl_amount.attributedText = attrStri
        }
        //PickUP Location
        var Str_OriginalFromdate = ""
        var Str_Originaltodate = ""

        if let str_fromDate = self.ary_PaymentHistoryInfo[indexPath.row].from_date, let str_toDate = self.ary_PaymentHistoryInfo[indexPath.row].to_date,str_fromDate != "" || str_toDate != "" {
            Str_OriginalFromdate = str_fromDate
            Str_Originaltodate = str_toDate
        } else if let str_fromDate = self.ary_PaymentHistoryInfo[indexPath.row].effectiveCreditDate, let str_toDate = self.ary_PaymentHistoryInfo[indexPath.row].effectiveDebitDate {
            Str_OriginalFromdate = str_fromDate + "04:00 AM"
            Str_Originaltodate = str_toDate + "03:59 AM"
        }
        
        // Date
        if Str_Originaltodate != "" || Str_OriginalFromdate != "" {
            let AttributeStr = "Start Date : " + Str_OriginalFromdate + "\nEnd Date : " + Str_Originaltodate
            let attrStri = NSMutableAttributedString.init(string:AttributeStr)
            var nsRange = NSString(string: AttributeStr).range(of: "Start Date :", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
            nsRange = NSString(string: AttributeStr).range(of: "End Date :", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange)
            cell.lbl_fromDate.attributedText = attrStri
        }

        
        cell.btn_viewInfo.isHidden = true
        cell.btn_viewInfo.tag = indexPath.row
        cell.btn_viewInfo.addTarget(self, action: #selector(viewPaymentDetailsButtonClicked), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //PickUP Location
        var Str_OriginalFromdate = ""
        var Str_Originaltodate = ""

        if let str_fromDate = self.ary_PaymentHistoryInfo[indexPath.row].from_date, let str_toDate = self.ary_PaymentHistoryInfo[indexPath.row].to_date,str_fromDate != "" || str_toDate != "" {
            Str_OriginalFromdate = str_fromDate
            Str_Originaltodate = str_toDate
        } else if let str_fromDate = self.ary_PaymentHistoryInfo[indexPath.row].effectiveCreditDate, let str_toDate = self.ary_PaymentHistoryInfo[indexPath.row].effectiveDebitDate {
            Str_OriginalFromdate = str_fromDate + "04:00 AM"
            Str_Originaltodate = str_toDate + "03:59 AM"
        }
        
        let Storyboard : UIStoryboard = UIStoryboard(name: "RidesHistory", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "WeekRideinfoViewController") as! WeekRideinfoViewController
        nxtVC.str_Todates = Str_Originaltodate
        nxtVC.str_Fromdate = Str_OriginalFromdate
        self.navigationController?.pushViewController(nxtVC, animated:  true)

    }
    
    @objc func viewPaymentDetailsButtonClicked(sender: UIButton) {
        
    }
    
}
extension WeeklyPaymentsViewController {
    
    //MARK: - Week Payment Details
    func getWeekPaymentDeatils() {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForWeeklyPaymentsServices(perams: ["driver_id":DriverLoginID]) { success, model, error in
            if success, let WeeklyPaymentsUserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if WeeklyPaymentsUserData.status == "1" {
                        if let data = WeeklyPaymentsUserData.week {
                            self.ary_PaymentHistoryInfo = data
                        }
                        self.ary_PaymentHistoryInfo.reverse()
                        self.tableview_PaymentHistoryRef.reloadData()

                    } else {
                        self.showToast(message: WeeklyPaymentsUserData.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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



