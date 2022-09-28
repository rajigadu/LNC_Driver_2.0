//
//  RegistrationViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 13/09/22.
//

import UIKit
import GooglePlaces
class RegistrationViewController: UIViewController {
    
    //MARK: - Class outlets
    @IBOutlet weak var firstNameTxtFld: UITextField!
    @IBOutlet weak var lastNameTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var mobileNoTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var confrimPasswordTxtFld: UITextField!
    @IBOutlet weak var txt_AdddressRef: UITextField!
    @IBOutlet weak var btn_SignRef: UIButton!
    @IBOutlet weak var txt_VehicleMakeTxtFld: UITextField!
    @IBOutlet weak var txt_VehicleModelTxtFld: UITextField!
    @IBOutlet weak var txt_VehicleYearTxtFld: UITextField!
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var profilePicButton: UIButton!
    
    @IBOutlet weak var vehiclePic: UIImageView!
    @IBOutlet weak var vehiclePicButton: UIButton!
    
    @IBOutlet weak var insurancePic: UIImageView!
    @IBOutlet weak var insurancePicButton: UIButton!
    
    @IBOutlet weak var drivingLicensePic: UIImageView!
    @IBOutlet weak var drivingLicensePicButton: UIButton!
    
    @IBOutlet weak var drivinfRecordPic: UIImageView!
    @IBOutlet weak var drivinfRecordPicButton: UIButton!
    
    @IBOutlet weak var selectBackgroundCheckBoxr: UIButton!
    @IBOutlet weak var selectCharSelectCheckBoxr: UIButton!
    @IBOutlet weak var selectW3CheckBoxr: UIButton!
    
    //MARK: - Class Propeties
    lazy var viewModel = {
        RegistrationViewModel()
    }()
    var addressID:String?
    var isBackgroundChecked = false
    var isCharTestPassChecked = false
    var isw3Checked = false
    
    var profilepicName = ""
    var profilepicr = UIImage()
    
    var vehicleImageName = ""
    var vehicleImage = UIImage()
    
    var InsuranceImage = UIImage()
    var InsuranceImageName = ""
    
    var license_image = UIImage()
    var license_image_name = ""
    
    var driver_abstract = UIImage()
    var driver_abstract_name = ""
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCharSelectCheckBoxr.setImage(UIImage(named: "uncheckimage"), for: .normal)
        selectBackgroundCheckBoxr.setImage(UIImage(named: "uncheckimage"), for: .normal)
        selectW3CheckBoxr.setImage(UIImage(named: "uncheckimage"), for: .normal)
        
        
        self.firstNameTxtFld.text = "Raj"
        self.lastNameTxtFld.text = "Venk"
        self.emailTxtFld.text = "venk@gmail.com"
        self.mobileNoTxtFld.text = "1234567890"
        self.passwordTxtFld.text = "123"
        self.confrimPasswordTxtFld.text = "123"
        self.txt_AdddressRef.text = "mamillapalli"
        self.addressID = "12"
        self.txt_VehicleMakeTxtFld.text = "ting"
        self.txt_VehicleModelTxtFld.text = "tong"
        self.txt_VehicleYearTxtFld.text = "2012"
        
    }
    
    //MARK: - Class Actions
    @IBAction func registrationBtn(_ sender: Any) {
        self.registrationApiCall()
    }
    
    
    @IBAction func onLaunchClicked(_ sender: UIButton) {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    //profile pic
    @IBAction func selectProfilePic(_ sender:Any) {
        self.profilepicName = ""
        ImagePickerManager().pickImage(self){ image in
            //here is the image
            self.profilePic.image = image
            self.profilepicName = "profilepic"
            self.profilepicr = image
        }
    }
    
    //vehicle image
    @IBAction func selectVehicleImage(_ sender: Any) {
        self.vehicleImageName = ""
        ImagePickerManager().pickImage(self){ image in
            //here is the image
            self.vehiclePic.image = image
            self.vehicleImageName = "vehicle_image"
            self.vehicleImage = image
        }
    }
    
    //Insurance pic
    @IBAction func selectInsurancePic(_ sender: Any) {
        self.InsuranceImageName = ""
        ImagePickerManager().pickImage(self){ image in
            //here is the image
            self.insurancePic.image = image
            self.InsuranceImageName = "documents_image"
            self.InsuranceImage = image
        }
    }
    
    //License pic
    @IBAction func selectLicensePic(_ sender: Any) {
        self.license_image_name = ""
        ImagePickerManager().pickImage(self){ image in
            //here is the image
            self.drivingLicensePic.image = image
            self.license_image_name = "license_image"
            self.license_image = image
        }
        
    }
    //Driving record
    @IBAction func selectDrivingRecord(_ sender: Any) {
        self.driver_abstract_name = ""
        ImagePickerManager().pickImage(self){ image in
            //here is the image
            self.drivinfRecordPic.image = image
            self.driver_abstract_name = "driver_abstract"
            self.driver_abstract = image
        }
    }
    
    
    //BackgroundCheck
    @IBAction func selectBackgroundCheckBox(_ sender: Any) {
        if isBackgroundChecked {
            isBackgroundChecked = false
            selectBackgroundCheckBoxr.setImage(UIImage(named: "checkbox_checked"), for: .normal)
        } else {
            isBackgroundChecked = true
            selectBackgroundCheckBoxr.setImage(UIImage(named: "uncheckimage"), for: .normal)
        }
    }
    
    //CharTestPassCheck
    @IBAction func selectCharSelectCheckBox(_ sender:Any) {
        if isCharTestPassChecked {
            isCharTestPassChecked = false
            selectCharSelectCheckBoxr.setImage(UIImage(named: "checkbox_checked"), for: .normal)
        } else {
            isCharTestPassChecked = true
            selectCharSelectCheckBoxr.setImage(UIImage(named: "uncheckimage"), for: .normal)
        }
    }
    
    //w3Checked
    @IBAction func selectW3CheckBox(_ sender: Any) {
        if isw3Checked {
            isw3Checked = false
            selectW3CheckBoxr.setImage(UIImage(named: "checkbox_checked"), for: .normal)
        } else {
            isw3Checked = true
            selectW3CheckBoxr.setImage(UIImage(named: "uncheckimage"), for: .normal)
        }
    }
    
    //w3 web form opening...
    @IBAction func openW3Webform(_ sender: Any) {
        self.movetonextvc(id: "W9FormViewController", storyBordid: "Authentication", animated: true)
    }
}
extension RegistrationViewController {
    //MARK: - Api Intigration
    func registrationApiCall(){
        guard let str_UserFirstName = firstNameTxtFld.text else {return}
        guard let str_UserLastName = lastNameTxtFld.text else {return}
        guard let str_UserEmail = emailTxtFld.text else {return}
        guard let str_UserMobilenumber = mobileNoTxtFld.text else {return}
        guard let str_Userpassword = passwordTxtFld.text else {return}
        guard let str_UserconfrimPassword = confrimPasswordTxtFld.text else {return}
        guard let str_UserAdddress = txt_AdddressRef.text else {return}
        guard let str_addressID = addressID else {return}
        guard let str_UserVtype = txt_VehicleMakeTxtFld.text else {return}
        guard let str_UserVModel = txt_VehicleModelTxtFld.text else {return}
        guard let str_UserMakingYear = txt_VehicleYearTxtFld.text else {return}
        
        if str_UserEmail.isEmpty {
            self.ShowAlert(message: "Please enter  email!")
        } else if !isValidEmail(str_UserEmail) {
            self.ShowAlert(message: "Please enter valid email!")
        } else if  str_UserFirstName.isEmpty || str_UserLastName.isEmpty {
            self.ShowAlert(message: "Please enter first/last name !")
        } else if str_UserMobilenumber.isEmpty {
            self.ShowAlert(message: "Please eneter mobile number!")
        } else if str_UserMobilenumber.count < 10 {
            self.ShowAlert(message: "Please eneter Valid mobile number!")
        } else if str_Userpassword.isEmpty || str_UserconfrimPassword.isEmpty {
            self.ShowAlert(message: "Please enter password/confrim password!")
        } else if str_UserAdddress.isEmpty || str_addressID.isEmpty {
            self.ShowAlert(message: "Please select the Address!")
        } else if str_Userpassword != str_UserconfrimPassword {
            self.ShowAlert(message: "confirm password does not match with password!")
        } else if str_UserMakingYear.isEmpty {
            self.ShowAlert(message: "Please eneter vehicle making year!")
        } else if str_UserVModel.isEmpty {
            self.ShowAlert(message: "Please eneter vehicle model!")
        } else if str_UserVtype.isEmpty {
            self.ShowAlert(message: "Please eneter vehicle type!")
        } else if profilepicName == "" {
            self.ShowAlert(message: "Please provide profile pic!")
        } else if vehicleImageName == "" {
            self.ShowAlert(message: "Please provide vehicle pic!")
        } else if InsuranceImageName == "" {
            self.ShowAlert(message: "Please provide Insurance pic!")
        } else if license_image_name == "" {
            self.ShowAlert(message: "Please provide license pic!")
        } else if driver_abstract_name == "" {
            self.ShowAlert(message: "Please provide driver abstract pic!")
        } else if isw3Checked {
            self.ShowAlert(message: "Please check W3 Form")
        } else if isCharTestPassChecked || isBackgroundChecked {
            self.ShowAlert(message: "Please check background check Form")
        }else {
            indicator.showActivityIndicator()
            let perams = [
                "fname":str_UserFirstName,
                "lname":str_UserLastName,
                "email":str_UserEmail,
                "mobile":str_UserMobilenumber,
                "password":str_Userpassword,
                "vtype":str_UserVtype,
                "makingyear":str_UserMakingYear,
                "vmodel":str_UserVModel,
                "address":str_UserAdddress,
            ]
            let peramModel = registartionStruct(str_fname: str_UserFirstName, str_lname: str_UserLastName, str_email: str_UserEmail, str_mobile: str_UserMobilenumber, str_password: str_Userpassword, str_vtype: str_UserVtype, str_makingyear: str_UserMakingYear, str_vmodel: str_UserVModel, str_address: str_UserAdddress)
            
            self.viewModel.requestForRegistrationServices(["json":perams.json],peramsModel :peramModel, profilepic_name: self.profilepicName, profilepic: profilepicr, vehicle_image_name: vehicleImageName, vehicle_image: vehicleImage, documents_image_name: InsuranceImageName, documents_image: InsuranceImage, license_image_name: license_image_name, license_image: license_image, driver_abstract_name: driver_abstract_name, driver_abstract: driver_abstract){ success, model, error in
                if success, let ForgotPasswordUserData = model {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        self.ShowAlertWithPop(message: ForgotPasswordUserData.userData?[0].Message ?? "password sent to your email address.")
                    }
                } else {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        self.showToast(message: error ?? "Something went wrong.", font: .systemFont(ofSize: 12.0))
                    }
                }
            }
        }
    }
}
extension RegistrationViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(String(describing: place.name))")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        self.addressID = place.placeID
        self.txt_AdddressRef.text = place.formattedAddress
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: \(error)")
        dismiss(animated: true, completion: nil)
    }
    
    // User cancelled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
    }
}
extension Dictionary {
    
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func printJson() {
        print(json)
    }
    
}
