//
//  AddManagePartnersViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import UIKit

class AddManagePartnersViewController: UIViewController {
    
    lazy var viewModel = {
        AddManagePartnersViewModel()
    }()
    
    @IBOutlet weak var txt_PartnerNameRef: UITextField!
    @IBOutlet weak var txt_PartnerMobilenumberRef: UITextField!
    @IBOutlet weak var txt_PartnerEmailIDRef: UITextField!
    @IBOutlet weak var btn_SubmitRef: UIButton!
    var loginDriverIDStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ADD MANAGE PARTNER"
        loginDriverIDStr = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        
        self.btn_SubmitRef.layer.cornerRadius = 5.0
        self.btn_SubmitRef.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_SubmitActionRef(_ sender: Any) {
        if self.txt_PartnerMobilenumberRef.text == "" || self.txt_PartnerNameRef.text == "" || self.txt_PartnerEmailIDRef.text == "" {
            self.ShowAlert(message: "All feilds are required!")
        } else if !(isValidEmail(self.txt_PartnerEmailIDRef.text ?? "")) {
            self.ShowAlert(message: "Please enter valid Email!")
        } else {
            self.AddNewPartner(pname: self.txt_PartnerNameRef.text ?? "",pemail: self.txt_PartnerEmailIDRef.text ?? "" ,pmobile:self.txt_PartnerMobilenumberRef.text ?? "")
        }
    }

}
extension AddManagePartnersViewController {
    func AddNewPartner(pname: String,pemail: String,pmobile:String) {
        guard let  DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForAddManagePartnersServices(perams: ["driverid": DriverLoginID,"pmobile":pmobile,"pemail":pemail,"pname":pname]) { success, model, error in
            if success, let GetBankDetailsModel = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.ShowAlertWithPop(message: GetBankDetailsModel.message ?? "Successfully addeded")
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
