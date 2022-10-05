//
//  ManagePartnersViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import UIKit

class ManagePartnersViewController: UIViewController {
    
    @IBOutlet weak var lbl_NoListRef: UILabel!
    @IBOutlet weak var tableview_ManagePartnersRef: UITableView!
    @IBOutlet weak var btn_AddPartnerActionRef: UIButton!
    
    var ManagePartnersDatarList: [ManagePartnersDatar] = []
    lazy var viewModel = {
        ManagePartnersViewModel()
    }()
    
    var loginDriverIDStr = ""
var SwitchStatus = "NO"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Manage Partners"
        self.tableview_ManagePartnersRef.estimatedRowHeight = 1000
        self.tableview_ManagePartnersRef.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
        loginDriverIDStr =  UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        lbl_NoListRef.isHidden = true
        //UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getListOfManagedPartners()
    }
    
    @IBAction func btn_AddPartnerActionRef(_ sender: Any) {
        self.movetonextvc(id: "AddManagePartnersViewController", storyBordid: "RidesHistory", animated: true)
    }
    
    @objc func switchChanged(sender: UISwitch) {
        let str_PartnerID = ManagePartnersDatarList[sender.tag].id ?? ""
        let str_PartnerActiveStatus = ManagePartnersDatarList[sender.tag].default_status ?? "NO"
        SwitchStatus = str_PartnerActiveStatus == "yes" ? "NO" : "YES"
        self.activatePartnerAPIwithstatus(partner_id: str_PartnerID, status: SwitchStatus)
    }
    
    @IBAction func btn_AddPartnerActionRef(sender: Any) {
        self.movetonextvc(id: "AddManagePartnersViewController", storyBordid: "RidesHistory", animated: true)
    }
}


extension ManagePartnersViewController {
    func getListOfManagedPartners() {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForManagePartnersServices(perams: ["driverid":DriverLoginID]) { success, model, error in
            if success, let GetBankDetailsModel = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let data = GetBankDetailsModel.data {
                        self.ManagePartnersDatarList = data
                    }
//                    self.ary_PaymentHistoryInfo.reverse()
                    self.tableview_ManagePartnersRef.reloadData()
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
extension ManagePartnersViewController {
    func activatePartnerAPIwithstatus(partner_id: String, status: String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForUpdatePartnerStatusService(perams: ["driverid":DriverLoginID, "partner_id":partner_id, "status":status]) { success, model, error in
            if success, let GetBankDetailsModel = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.ShowAlert(message: GetBankDetailsModel.data?[0].message ?? "")
                    self.getListOfManagedPartners()
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
extension ManagePartnersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView, ArrayCount: ManagePartnersDatarList.count, numberOfsections: 1, data_MSG_Str: "No records found!")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManagePartnersDatarList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:ManagePartnerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ManagePartnerTableViewCell", for: indexPath) as? ManagePartnerTableViewCell else {return UITableViewCell()}
        
        cell.lbl_PartnerNameRef.text = "Partner name : " + (ManagePartnersDatarList[indexPath.row].partner_name ?? "")
        
        cell.lbl_PartnerEmailRef.text = "Partner name : " + (ManagePartnersDatarList[indexPath.row].partner_email ?? "")
        
        cell.lbl_PartnerNumberRef.text = "Partner phone : " + (ManagePartnersDatarList[indexPath.row].partner_phone ?? "")
        let str_PartnerActiveStatus = ManagePartnersDatarList[indexPath.row].default_status ?? ""
        if str_PartnerActiveStatus == "yes" {
            cell.switch_Ref.setOn(true, animated: true)
        } else {
            cell.switch_Ref.setOn(false, animated: true)
        }
        cell.switch_Ref.tag = indexPath.row
        cell.switch_Ref.addTarget(self, action: #selector(switchChanged), for: .touchUpInside)
        return cell
    }
    
    
}
