//
//  AddBankDetailsViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 15/09/22.
//

import UIKit

class AddBankDetailsViewController: UIViewController {
    
    @IBOutlet weak var txt_MobileNumberRef: UITextField!
    @IBOutlet weak var txt_FirstNameRef:UITextField!
    @IBOutlet weak var txt_LastNameRef:UITextField!
    @IBOutlet weak var txt_ACNumberRef:UITextField!
    @IBOutlet weak var txt_ReEnterACNumberRef:UITextField!
    //@property (weak, nonatomic) IBOutlet UITextField *txt_BankSecurityCodeRef;
    @IBOutlet weak var txt_RouteNoRef:UITextField!
    @IBOutlet weak var Txt_BankACRef:UITextField!
    @IBOutlet weak var btn_SubmitActionRef:UIButton!
    
    lazy var viewModel = {
        AddBankDetailsViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ADD BANK ACCOUNT"
        self.getBankDeatils()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btn_SubmitActionRef(_ sender: UIButton) {
        AddBankDetailsApiCall()
    }
    
}
extension AddBankDetailsViewController {
    
    //MARK: - Api Intigration
    func AddBankDetailsApiCall(){
        guard let mobileNumber = txt_MobileNumberRef.text else {return}
        guard let firstName = txt_FirstNameRef.text else {return}
        guard let lastName = txt_LastNameRef.text else {return}
        guard let accountNumb = txt_ACNumberRef.text else {return}
        guard let reEnterAccountNumb = txt_ReEnterACNumberRef.text else {return}
        guard let routeNum = txt_RouteNoRef.text else {return}
        guard let bankAC = Txt_BankACRef.text else {return}
        
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        
        if mobileNumber.isEmpty || firstName.isEmpty || lastName.isEmpty || accountNumb.isEmpty || accountNumb != reEnterAccountNumb || routeNum.isEmpty || bankAC.isEmpty {
            self.ShowAlert(message: "Please Eneter Valid Credentials!")
        } else {
            let perams = ["driverid":str_userID,"fname":firstName,"lname":lastName,"mobile":mobileNumber,"accnumber":accountNumb,"routingnumber":routeNum,"bankName":bankAC]
            indicator.showActivityIndicator()
            
            self.viewModel.requestForAddBankDetailsServices(perams: ["json":perams.json]) { success, model, error in
                if success, let AddBankDetailsModel = model {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        if AddBankDetailsModel.loginStatus == "1" {
                            self.ShowAlertWithPop(message: AddBankDetailsModel.message ?? "Profile updated  successfully.")
                        } else {
                            self.showToast(message: AddBankDetailsModel.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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
    
}

extension AddBankDetailsViewController {
    
    //MARK: - Get Bank Details
    func getBankDeatils() {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForGetBankDetailsServices(perams: ["driverid":str_userID]) { success, model, error in
            if success, let GetBankDetailsModel = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    
                    if GetBankDetailsModel.loginStatus == "1" {
                        self.txt_MobileNumberRef.text = GetBankDetailsModel.userData?[0].mobile
                        self.txt_FirstNameRef.text = GetBankDetailsModel.userData?[0].fname
                        self.txt_LastNameRef.text = GetBankDetailsModel.userData?[0].lname
                        self.txt_ACNumberRef.text = GetBankDetailsModel.userData?[0].accnumber
                        self.txt_ReEnterACNumberRef.text = GetBankDetailsModel.userData?[0].accnumber
                        self.txt_RouteNoRef.text = GetBankDetailsModel.userData?[0].routingnumber
                        self.Txt_BankACRef.text = GetBankDetailsModel.userData?[0].bank_name
                    } else {
                        self.showToast(message: GetBankDetailsModel.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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



