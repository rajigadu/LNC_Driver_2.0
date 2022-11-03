//
//  DriverTypeViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import UIKit

struct partnerAdd {
    var partner_name : String
    var partner_phone : String
    var partner_email : String
}

class DriverTypeViewController: UIViewController {
    
    @IBOutlet weak var btn_DriverType1Ref: UIButton!
    @IBOutlet weak var btn_DriverType2Ref: UIButton!
    @IBOutlet weak var btn_DriverType3Ref: UIButton!
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
    var ary_PartnerListRef: [partnerAdd] = []
    var partnerPicker: UIPickerView!
    var str_DriverLoginID = ""
    
    var array_PartnerListReff:[DriverTypeDatar] = []
    
    lazy var viewModel = {
        DriverTypeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Driver Type"
        str_CheckingSelectedDriverType = "1"
        isDefaultpartner = "yes"
        isPartnerStatusEnabled = true
        self.btn_DriverType3Ref.setImage(UIImage(named: "checkbox_checked"), for: .normal)
        str_DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        
        self.txt_PartnerMobilenumberRef.isUserInteractionEnabled = true
        self.txt_PartnerNameref.isUserInteractionEnabled = true
        self.txt_PartnerMailRef.isUserInteractionEnabled = true
        self.btn_DriverType1Ref.setImage(UIImage(named: "Circle"), for: .normal)
        self.btn_DriverType2Ref.setImage(UIImage(named: "emptyCircle"), for: .normal)
        
        self.ary_PartnerListRef.append(partnerAdd(partner_name: "ADD NEW PARTNER", partner_phone: "1234567890", partner_email: "test@test.com"))
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
        self.btn_DriverType3Ref.tag = 202
        
        self.activePartnerAPI(withDriverID: str_DriverLoginID)
    }
    
    
    @IBAction func openedMenuBtnref(_ sender: Any) {
        self.navigateToSideMenu()
    }
    
    @IBAction func btn_DriverTypeUpdateAction(_ sender: UIButton) {
        switch sender.tag {
        case 200:
            self.view_BackgroundRef.isHidden = false
            self.view_ConstraintRef.constant = 400
            str_CheckingSelectedDriverType = "1"
            self.txt_PartnerMobilenumberRef.isUserInteractionEnabled = true
            self.txt_PartnerNameref.isUserInteractionEnabled = true
            self.txt_PartnerMailRef.isUserInteractionEnabled = true
            self.btn_DriverType1Ref.setImage(UIImage(named: "Circle"), for: .normal)
            self.btn_DriverType2Ref.setImage(UIImage(named: "emptyCircle"), for: .normal)
            self.btn_DriverType3Ref.setImage(UIImage(named: "checkbox_checked"), for: .normal)
            break
        case 201:
            self.view_BackgroundRef.isHidden = true
            str_CheckingSelectedDriverType = "2"
            isDefaultpartner = "no"
            self.view_ConstraintRef.constant = 150
            self.txt_PartnerMobilenumberRef.isUserInteractionEnabled = false
            self.txt_PartnerNameref.isUserInteractionEnabled = false
            self.txt_PartnerMailRef.isUserInteractionEnabled = false
            
            self.btn_DriverType1Ref.setImage(UIImage(named: "emptyCircle"), for: .normal)
            self.btn_DriverType2Ref.setImage(UIImage(named: "Circle"), for: .normal)
            self.btn_DriverType3Ref.setImage(UIImage(named: "uncheckimage"), for: .normal)
            break

        case 202:
            
            self.view_BackgroundRef.isHidden = true
            isDefaultpartner = "yes"
            self.view_ConstraintRef.constant = 150
            self.txt_PartnerMobilenumberRef.isUserInteractionEnabled = false
            self.txt_PartnerNameref.isUserInteractionEnabled = false
            self.txt_PartnerMailRef.isUserInteractionEnabled = false
            self.btn_DriverType1Ref.setImage(UIImage(named: "emptyCircle"), for: .normal)
            self.btn_DriverType2Ref.setImage(UIImage(named: "emptyCircle"), for: .normal)
            self.btn_DriverType3Ref.setImage(UIImage(named: "checkbox_checked"), for: .normal)
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
                self.selectDriverTypeAPI(withPName: self.txt_PartnerNameref.text ?? "", withPEmail: self.txt_PartnerMailRef.text ?? "", withPMobile: self.txt_PartnerMobilenumberRef.text ?? "", withSelectedType: str_CheckingSelectedDriverType, withLoginDriverID: str_DriverLoginID)
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
extension DriverTypeViewController: UIPickerViewDelegate, UIPickerViewDataSource{
   

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
        } else {
            self.txt_PartnerNameref.text = ary_PartnerListRef[row].partner_name
            self.txt_PartnerMailRef.text = ary_PartnerListRef[row].partner_email
            self.txt_PartnerMobilenumberRef.text = ary_PartnerListRef[row].partner_phone
        }
    }
}
//MARK: - ActivePartnerAPI
extension DriverTypeViewController {
    func activePartnerAPI(withDriverID: String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForActivePartnerAPIServices(perams: ["driverid":DriverLoginID]) { success, model, error in
            if success, let ActivePartner = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                     if ActivePartner.status == "1" {
                        str_CheckingSelectedDriverType = ActivePartner.status ?? ""
                        self.txt_PartnerMobilenumberRef.isUserInteractionEnabled = true
                        self.txt_PartnerNameref.isUserInteractionEnabled = true
                        self.txt_PartnerMailRef.isUserInteractionEnabled = true
                        
                        self.txt_PartnerNameref.text = ActivePartner.data?.partner_name ?? ""
                        self.txt_PartnerMailRef.text = ActivePartner.data?.partner_email ?? ""
                        self.txt_PartnerMobilenumberRef.text = ActivePartner.data?.partner_phone ?? ""
                        
                        self.btn_DriverType1Ref.setImage(UIImage(named: "Circle"), for: .normal)
                        self.btn_DriverType2Ref.setImage(UIImage(named: "emptyCircle"), for: .normal)
                         
                        self.partnerListAPI()

                    } else {
                        str_CheckingSelectedDriverType = "1"
                        self.txt_PartnerMobilenumberRef.isUserInteractionEnabled = true
                        self.txt_PartnerNameref.isUserInteractionEnabled = true
                        self.txt_PartnerMailRef.isUserInteractionEnabled = true
                        self.btn_DriverType1Ref.setImage(UIImage(named: "Circle"), for: .normal)
                        self.btn_DriverType2Ref.setImage(UIImage(named: "emptyCircle"), for: .normal)
                        
                        self.partnerListAPI()
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

//MARK: -  selectDriverTypeAPI
extension DriverTypeViewController {
    func selectDriverTypeAPI(withPName: String, withPEmail: String, withPMobile: String, withSelectedType: String, withLoginDriverID: String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        var perams = [String : String]()
        if str_CheckingSelectedDriverType == "1" {
            if self.str_CurrentRide == "" {
                perams = ["pname": withPName, "pemail": withPEmail, "pmobile":withPMobile, "driver_type":withSelectedType,"driverid":DriverLoginID,"default":"yes"]
            } else {
                perams = ["pname": withPName, "pemail": withPEmail, "pmobile":withPMobile, "driver_type":withSelectedType,"driverid":DriverLoginID,"default":"yes", "ride_id" : self.str_CurrentRide]
            }
            
        } else if str_CheckingSelectedDriverType == "2" {
            perams = ["driver_type": str_CheckingSelectedDriverType, "driverid":DriverLoginID, "default":"no"]
        }
        
        self.viewModel.requestForSelectDriverTypeAPIServices(perams: perams) { success, model, error in
            if success, let SelectDriverType = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    
                    if SelectDriverType.status == "1" {
                        if self.str_CheckingFromRide == "AcceptRideCase" {
                            if str_CheckingSelectedDriverType == "1" {
                                UserDefaults.standard.set("1", forKey: "DriverServiceType")
                                self.movetonextvc(id: "DashBoardViewController", storyBordid: "DashBoard", animated: true)
                            } else {
                                UserDefaults.standard.set("2", forKey: "DriverServiceType")
                                self.lookingForPartnerAPI(WithRequestID: self.str_CurrentRide, withStatus: "p")
                            }
                        } else {
                            var str_ServiceType = SelectDriverType.data?[1].service_type ?? ""
                            UserDefaults.standard.set(str_ServiceType, forKey: "DriverServiceType")
                            self.ShowAlertWithPush(message: SelectDriverType.data?[0].message ?? "", className: "DashBoardViewController", storyBoard: "DashBoard", Animation: true)
                        }
                    } else {
                        self.showToast(message: SelectDriverType.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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

//MARK: - LookingForPartnerAPI
extension DriverTypeViewController {
    func lookingForPartnerAPI(WithRequestID: String, withStatus: String) {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForLookingForPartnerAPIServices(perams: ["request_id":WithRequestID, "status":withStatus]) { success, model, error in
            if success, let LookingForPartner = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
 
                    if LookingForPartner.status == "1" {
                        self.ShowAlertWithPush(message: LookingForPartner.message ?? "", className: "DashBoardViewController", storyBoard: "DashBoard", Animation: true)
                    } else {
                        self.showToast(message: LookingForPartner.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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

//MRK:- PartnerListAPI
extension DriverTypeViewController {
    func partnerListAPI() {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForPartnerListAPIServices(perams: ["driverid":DriverLoginID]) { success, model, error in
            if success, let PartnerList = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    
                    if PartnerList.status == "1" {
                        if let responseData = PartnerList.data {
                            array_PartnerListReff = responseData
                        }
                       
                        for response in array_PartnerListReff {
                            let str_PartnerName = response.partner_name ?? ""
                            let str_PartnerPhone = response.partner_phone ?? ""
                            let str_PartnerEmail = response.partner_email ?? ""
                            self.ary_PartnerListRef.append(partnerAdd(partner_name: str_PartnerName, partner_phone: str_PartnerPhone, partner_email: str_PartnerEmail))
                        }
                        self.partnerPicker.reloadAllComponents()

                    } else {
                        self.showToast(message: PartnerList.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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
