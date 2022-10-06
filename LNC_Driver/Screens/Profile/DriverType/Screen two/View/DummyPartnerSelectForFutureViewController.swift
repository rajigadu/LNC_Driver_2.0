//
//  DummyPartnerSelectForFutureViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 30/09/22.
//

import UIKit

struct partnerAdd2 {
    var partner_name : String
    var partner_phone : String
    var partner_email : String
    var partner_id : String
}

class DummyPartnerSelectForFutureViewController: UIViewController {
    
    @IBOutlet weak var btn_DriverType1Ref: UIButton!
    @IBOutlet weak var btn_DriverType2Ref: UIButton!
    @IBOutlet weak var txt_PartnerNameref: UITextField!
    @IBOutlet weak var txt_PartnerMailRef: UITextField!
    @IBOutlet weak var txt_PartnerMobilenumberRef: UITextField!
    @IBOutlet weak var btn_SubmitRef: UIButton!
    @IBOutlet weak var view_BackgroundRef: UIView!
    @IBOutlet weak var txt_SelectPartnerRef: UITextField!
    @IBOutlet weak var view_ConstraintRef: NSLayoutConstraint!
    
    
    var str_ComingFromHome = ""
    var str_CheckingFromRide = ""
    var str_CurrentRide = ""
    var str_CheckingSelectedDriverType = ""
    var isDefaultpartner = ""
    var isPartnerStatusEnabled = false
    var ary_PartnerListRef: [partnerAdd2] = []
    var partnerPicker: UIPickerView!
    var str_DriverLoginID = ""
    
    var array_PartnerListReff:[DriverTypeDatar] = []
    
    var str_SelectedFutureRideID = ""
    var str_SelectedDummyPartnerID = ""
    
    lazy var viewModel = {
        DriverTypeViewModel()
    }()
    lazy var viewModel2 = {
        DummyPartnerSelectForFutureViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Driver Type"
        str_CheckingSelectedDriverType = "1"
        isDefaultpartner = "yes"
        isPartnerStatusEnabled = true
        str_DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        
        self.txt_PartnerMobilenumberRef.isUserInteractionEnabled = true
        self.txt_PartnerNameref.isUserInteractionEnabled = true
        self.txt_PartnerMailRef.isUserInteractionEnabled = true
        self.btn_DriverType1Ref.setImage(UIImage(named: "Circle"), for: .normal)
        self.btn_DriverType2Ref.setImage(UIImage(named: "emptyCircle"), for: .normal)
        
        self.ary_PartnerListRef.append(partnerAdd2(partner_name: "ADD NEW PARTNER", partner_phone: "1234567890", partner_email: "test@test.com", partner_id: "dummy_id"))
        // Do any additional setup after loading the view.
        
        partnerPicker = UIPickerView()
        
        partnerPicker.dataSource = self
        partnerPicker.delegate = self
        
        txt_SelectPartnerRef.inputView = partnerPicker
        txt_SelectPartnerRef.text = ""
        
        self.btn_SubmitRef.layer.cornerRadius = 5.0
        self.btn_SubmitRef.layer.masksToBounds = true
        
        self.btn_DriverType1Ref.tag = 200
        self.btn_DriverType2Ref.tag = 201
        
        self.partnerListAPI()
    }
    
    @IBAction func openDriverbtnref(_ sender: Any) {
        self.navigateToSideMenu()
    }
    
    @IBAction func btn_DriverTypeUpdateAction(_ sender: UIButton) {
        switch sender.tag {
        case 200:
            self.view_BackgroundRef.isHidden = false
            self.view_ConstraintRef.constant = 300
            str_CheckingSelectedDriverType = "1"
            self.txt_PartnerMobilenumberRef.isUserInteractionEnabled = true
            self.txt_PartnerNameref.isUserInteractionEnabled = true
            self.txt_PartnerMailRef.isUserInteractionEnabled = true
            self.btn_DriverType1Ref.setImage(UIImage(named: "Circle"), for: .normal)
            self.btn_DriverType2Ref.setImage(UIImage(named: "emptyCircle"), for: .normal)
             break
        case 201:
            self.view_BackgroundRef.isHidden = true
            str_CheckingSelectedDriverType = "2"
            isDefaultpartner = "no"
            self.view_ConstraintRef.constant = 100
            self.txt_PartnerMobilenumberRef.isUserInteractionEnabled = false
            self.txt_PartnerNameref.isUserInteractionEnabled = false
            self.txt_PartnerMailRef.isUserInteractionEnabled = false
            
            self.btn_DriverType1Ref.setImage(UIImage(named: "emptyCircle"), for: .normal)
            self.btn_DriverType2Ref.setImage(UIImage(named: "Circle"), for: .normal)
            break
        default:
            print("")
        }
        
    }
    
    @IBAction func btn_SubmitActionRef(_ sender: Any) {
        if str_CheckingSelectedDriverType == "" {
            self.ShowAlert(message: "Please select partner Type")
        } else {
            if str_CheckingSelectedDriverType == "2" {
                //MARK: - Accepted Ride Info
                
            } else {
                if self.txt_PartnerMailRef.text == "" || self.txt_PartnerNameref.text == "" || self.txt_PartnerMobilenumberRef.text == "" {
                    self.ShowAlert(message: "All feilds are required!")
                } else {
                    self.selectDriverTypeAPI(withPName: self.txt_PartnerNameref.text ?? "", withPEmail: self.txt_PartnerMailRef.text ?? "", withPMobile: self.txt_PartnerMobilenumberRef.text ?? "", withSelectedType: str_CheckingSelectedDriverType, withLoginDriverID: str_DriverLoginID)
                }
            }
        }
    }
}
extension DummyPartnerSelectForFutureViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ary_PartnerListRef.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return ary_PartnerListRef[row].partner_name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.txt_SelectPartnerRef.text = ary_PartnerListRef[row].partner_name
        let str_ChooseType = ary_PartnerListRef[row].partner_name
        if str_ChooseType == "ADD NEW PARTNER" {
            self.txt_PartnerNameref.text = ""
            self.txt_PartnerMailRef.text = ""
            self.txt_PartnerMobilenumberRef.text = ""
            str_SelectedDummyPartnerID = ""
        } else {
            self.txt_PartnerNameref.text = ary_PartnerListRef[row].partner_name
            self.txt_PartnerMailRef.text = ary_PartnerListRef[row].partner_email
            self.txt_PartnerMobilenumberRef.text = ary_PartnerListRef[row].partner_phone
            str_SelectedDummyPartnerID = ary_PartnerListRef[row].partner_id
        }
    }
}

//MARK: -  selectDriverTypeAPI
extension DummyPartnerSelectForFutureViewController {
    func selectDriverTypeAPI(withPName: String, withPEmail: String, withPMobile: String, withSelectedType: String, withLoginDriverID: String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        var perams = [String : String]()
        perams = ["pname": withPName, "pemail": withPEmail, "pmobile":withPMobile, "driverid":DriverLoginID,"ride_id":self.str_SelectedFutureRideID, "dummy_id" : str_SelectedDummyPartnerID]
        
        self.viewModel2.requestForDummyPartnerSelectForFutureServices(perams: perams) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.ShowAlertWithPush(message: UserData.msg ?? "", className: "DashBoardViewController", storyBoard: "DashBoard", Animation: true)
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


//MRK:- PartnerListAPI
extension DummyPartnerSelectForFutureViewController {
    func partnerListAPI() {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForPartnerListAPIServices(perams: ["driverid":DriverLoginID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let responseData = userData.data {
                        array_PartnerListReff = responseData
                    }
                    
                    for response in array_PartnerListReff {
                        let str_PartnerName = response.partner_name ?? ""
                        let str_PartnerPhone = response.partner_phone ?? ""
                        let str_PartnerEmail = response.partner_email ?? ""
                        let str_PartnerId = response.id ?? ""
                        self.ary_PartnerListRef.append(partnerAdd2(partner_name: str_PartnerName, partner_phone: str_PartnerPhone, partner_email: str_PartnerEmail,partner_id: str_PartnerId))
                    }
                    self.partnerPicker.reloadAllComponents()
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
