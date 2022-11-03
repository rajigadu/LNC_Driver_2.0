//
//  AddVehicleInfoViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 15/09/22.
//

import UIKit

class AddVehicleInfoViewController: UIViewController {
    
    //MARK: - Class outlets
    @IBOutlet weak var btn_SignRef: UIButton!
    @IBOutlet weak var txt_VehicleMakeTxtFld: UITextField!
    @IBOutlet weak var txt_VehicleModelTxtFld: UITextField!
    @IBOutlet weak var txt_VehicleYearTxtFld: UITextField!
    
    @IBOutlet weak var vehiclePic: UIImageView!
    @IBOutlet weak var vehiclePicButton: UIButton!
    
    @IBOutlet weak var insurancePic: UIImageView!
    @IBOutlet weak var insurancePicButton: UIButton!
    
    @IBOutlet weak var drivingLicensePic: UIImageView!
    @IBOutlet weak var drivingLicensePicButton: UIButton!
    
    @IBOutlet weak var drivinfRecordPic: UIImageView!
    @IBOutlet weak var drivinfRecordPicButton: UIButton!
    
    //MARK: - Class Propeties
    lazy var viewModel = {
        AddVehicleInfoViewModel()
    }()
    var addressID:String?
    var isBackgroundChecked = false
    var isCharTestPassChecked = false
    var isw3Checked = false
    
    var vehicleImageName = ""
    var vehicleImage = UIImage()
    
    var InsuranceImage = UIImage()
    var InsuranceImageName = ""
    
    var license_image = UIImage()
    var license_image_name = ""
    
    var driver_abstract = UIImage()
    var driver_abstract_name = ""
    
    var vehicleStruct = uploadImage()
    var InsuranceStruct = uploadImage()
    var licenseStrct = uploadImage()
    var driverAbstractStruct = uploadImage()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Vehicle Info"
        self.getVehicleDeatils()
    }
    
    //MARK: - Class Actions
    @IBAction func registrationBtn(_ sender: Any) {
        self.editVehicleInfo()
    }
    
    //vehicle image
    @IBAction func selectVehicleImage(_ sender: Any) {
        self.vehicleImageName = ""
        self.vehiclePic.image = UIImage(named: "placeholder")
        vehicleStruct.Imagepic = nil
        vehicleStruct.ImageName = ""
        vehicleStruct.imagetype = ""
        vehicleStruct.ImageUrl = ""
        
        ImagePickerManager().pickImage(self){ image in
            //here is the image
            self.vehiclePic.image = image
            self.vehicleImageName = "vehicle_image"
            self.vehicleImage = image
            
            self.vehicleStruct.Imagepic = image
            self.vehicleStruct.ImageName = "vehicle_image"
            self.vehicleStruct.imagetype = "Device"
            self.vehicleStruct.ImageUrl = ""
        }
    }
    
    //Insurance pic
    @IBAction func selectInsurancePic(_ sender: Any) {
        self.InsuranceImageName = ""
        self.insurancePic.image = UIImage(named: "placeholder")
        InsuranceStruct.Imagepic = nil
        InsuranceStruct.ImageName = ""
        InsuranceStruct.imagetype = ""
        InsuranceStruct.ImageUrl = ""
        ImagePickerManager().pickImage(self){ image in
            //here is the image
            self.insurancePic.image = image
            self.InsuranceImageName = "documents_image"
            self.InsuranceImage = image
            
            self.InsuranceStruct.Imagepic = image
            self.InsuranceStruct.ImageName = "documents_image"
            self.InsuranceStruct.imagetype = "Device"
            self.InsuranceStruct.ImageUrl = ""
        }
    }
    
    //License pic
    @IBAction func selectLicensePic(_ sender: Any) {
        self.license_image_name = ""
        self.drivingLicensePic.image = UIImage(named: "placeholder")
        licenseStrct.Imagepic = nil
        licenseStrct.ImageName = ""
        licenseStrct.imagetype = ""
        licenseStrct.ImageUrl = ""
         ImagePickerManager().pickImage(self){ image in
            //here is the image
            self.drivingLicensePic.image = image
            self.license_image_name = "license_image"
            self.license_image = image
             
             self.licenseStrct.Imagepic = image
             self.licenseStrct.ImageName = "license_image"
             self.licenseStrct.imagetype = "Device"
             self.licenseStrct.ImageUrl = ""
        }
    }
    
    //Driving record
    @IBAction func selectDrivingRecord(_ sender: Any) {
        self.driver_abstract_name = ""
        self.drivinfRecordPic.image = UIImage(named: "placeholder")
        driverAbstractStruct.Imagepic = nil
        driverAbstractStruct.ImageName = ""
        driverAbstractStruct.imagetype = ""
        driverAbstractStruct.ImageUrl = ""
         ImagePickerManager().pickImage(self){ image in
            //here is the image
            self.drivinfRecordPic.image = image
            self.driver_abstract_name = "driver_abstract"
            self.driver_abstract = image
             
             self.driverAbstractStruct.Imagepic = image
             self.driverAbstractStruct.ImageName = "driver_abstract"
             self.driverAbstractStruct.imagetype = "Device"
             self.driverAbstractStruct.ImageUrl = ""
        }
    }
}

extension AddVehicleInfoViewController {
    
    //MARK: - Get Bank Details
    func getVehicleDeatils() {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForGetVehicleDetailsServices(perams: ["driverid":str_userID]) { success, model, error in
            if success, let getVehicleInfo = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    
                    if getVehicleInfo.loginStatus == "1" {
                    self.txt_VehicleMakeTxtFld.text = getVehicleInfo.userData?.vehicle_type
                    self.txt_VehicleYearTxtFld.text = getVehicleInfo.userData?.vehile_making_year
                    self.txt_VehicleModelTxtFld.text = getVehicleInfo.userData?.vehicle_model
                    
                    //vehicle image
                    if let Str_VehicleImage = API_URl.API_IMAGEBASE_URL + (getVehicleInfo.userData?.vehicle_image ?? "") as? String {
                        self.vehiclePic.sd_setImage(with: URL(string: Str_VehicleImage), placeholderImage: UIImage(named: "placeholder"))
                        self.vehicleImageName = "vehicle_image"
                        self.vehicleStruct.Imagepic = self.vehiclePic.image
                        self.vehicleStruct.ImageName = "vehicle_image"
                        self.vehicleStruct.imagetype = "URL"
                        self.vehicleStruct.ImageUrl = Str_VehicleImage
                     } else {
                        self.vehiclePic.image = UIImage(named: "placeholder")
                    }
                    
                    //license image
                    if let Str_LicenseImage = API_URl.API_IMAGEBASE_URL + (getVehicleInfo.userData?.license_image ?? "") as? String {
                        self.drivingLicensePic.sd_setImage(with: URL(string: Str_LicenseImage), placeholderImage: UIImage(named: "placeholder"))
                        self.license_image_name = "license_image"
                        
                         self.licenseStrct.Imagepic = self.drivingLicensePic.image
                        self.licenseStrct.ImageName = "license_image"
                        self.licenseStrct.imagetype = "URL"
                        self.licenseStrct.ImageUrl = Str_LicenseImage
                     } else {
                        self.insurancePic.image = UIImage(named: "placeholder")
                    }
                    //document image
                    if let Str_DocumentImage = API_URl.API_IMAGEBASE_URL + (getVehicleInfo.userData?.document_image ?? "") as? String {
                        self.insurancePic.sd_setImage(with: URL(string: Str_DocumentImage), placeholderImage: UIImage(named: "placeholder"))
                        self.InsuranceImageName = "documents_image"
                        
                        self.InsuranceStruct.Imagepic = self.insurancePic.image
                       self.InsuranceStruct.ImageName = "documents_image"
                       self.InsuranceStruct.imagetype = "URL"
                       self.InsuranceStruct.ImageUrl = Str_DocumentImage

                    } else {
                        self.drivingLicensePic.image = UIImage(named: "placeholder")
                    }
                    //abstract image
                    if let Str_AbstractImage = API_URl.API_IMAGEBASE_URL + (getVehicleInfo.userData?.abstract_image ?? "") as? String {
                        self.drivinfRecordPic.sd_setImage(with: URL(string: Str_AbstractImage), placeholderImage: UIImage(named: "placeholder"))
                        self.driver_abstract_name = "driver_abstract"
                        
                        self.driverAbstractStruct.Imagepic = self.drivinfRecordPic.image
                       self.driverAbstractStruct.ImageName = "driver_abstract"
                       self.driverAbstractStruct.imagetype = "URL"
                       self.driverAbstractStruct.ImageUrl = Str_AbstractImage

                    } else {
                        self.drivinfRecordPic.image = UIImage(named: "placeholder")
                    }
                    } else {
                        self.showToast(message: getVehicleInfo.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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

extension AddVehicleInfoViewController {
    //Edit vehicle Info
    func editVehicleInfo() {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        guard let str_UserVtype = txt_VehicleMakeTxtFld.text else {return}
        guard let str_UserVModel = txt_VehicleModelTxtFld.text else {return}
        guard let str_UserMakingYear = txt_VehicleYearTxtFld.text else {return}
        
        if str_UserMakingYear.isEmpty {
            self.ShowAlert(message: "Please eneter vehicle making year!")
        } else if str_UserVModel.isEmpty {
            self.ShowAlert(message: "Please eneter vehicle model!")
        } else if str_UserVtype.isEmpty {
            self.ShowAlert(message: "Please eneter vehicle type!")
        } else if vehicleImageName == "" {
            self.ShowAlert(message: "Please provide vehicle pic!")
        } else if InsuranceImageName == "" {
            self.ShowAlert(message: "Please provide Insurance pic!")
        } else if license_image_name == "" {
            self.ShowAlert(message: "Please provide license pic!")
        } else if driver_abstract_name == "" {
            self.ShowAlert(message: "Please provide driver abstract pic!")
        }else {
            indicator.showActivityIndicator()
            let perams = [
                "vehicle_type":str_UserVtype,
                "vehile_making_year":str_UserMakingYear,
                "vehicle_model":str_UserVModel,
                "driverid":str_userID,
            ]
            
            self.viewModel.requestForPostVehicleDetailsServices(perams, vehicle_image_name: self.vehicleImageName, vehicle_image: self.vehicleImage, documents_image_name: self.InsuranceImageName, documents_image: self.InsuranceImage, license_image_name: self.license_image_name, license_image: self.license_image, driver_abstract_name: self.driver_abstract_name, driver_abstract: self.driver_abstract, vehicleImageStruct: self.vehicleStruct, documentImageStruct: self.InsuranceStruct, licenseImageStruct: self.licenseStrct, driverAbstactImageStruct: self.driverAbstractStruct) { success, model, error in
            
                if success, let PostVehicleDetails = model {
                    DispatchQueue.main.async { [self] in
                        indicator.hideActivityIndicator()
                        if PostVehicleDetails.status == "1" {
                            self.ShowAlertWithPop(message: PostVehicleDetails.message ?? "password sent to your email address.")
                        } else {
                            self.showToast(message: PostVehicleDetails.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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
