//
//  SideMenuViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 15/09/22.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    //MARK: - Class outlets
    @IBOutlet weak var lbl_UserNameRef: UILabel!
    @IBOutlet weak var view_BackgroundRef: UIView!
    @IBOutlet weak var lbl_AverageRatingRef: UILabel!
    @IBOutlet weak var imageview_ProfileRef: UIImageView!
    @IBOutlet weak var tableview_MenuSliderRef: UITableView!
    
    //MARK: - Class Propeties
    lazy var viewModel = {
        MenuSliderViewModel()
    }()
    var arrayResponse = ["Home","Driver Type","Ride Reservations","Accepted Rides","Manage Partners","Ride History","Payment History","Weekly Payments","My Rewards","Settings","Employee Guidelines","Logout"];//@"Future Ride Info",@"Future Ride History","Trany Videos"
    
    var arr_images = [UIImage(named :"home"),UIImage(named :"user"),UIImage(named :"serviceinfo"),UIImage(named :"serviceinfo"),UIImage(named :"user"),UIImage(named :"history"),UIImage(named :"payment"),UIImage(named :"payment"),UIImage(named :"payment"),UIImage(named :"settings"),UIImage(named :"serviceinfo"),UIImage(named :"signout"),]//UIImage(named :"payment")
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Hide the Navigation Bar
        self.loadUserData()
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    //
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(true)
    //        // Show the Navigation Bar
    //        self.navigationController?.setNavigationBarHidden(false, animated: false)
    //    }
    
    
    //MARK: - Class Actions
    
    func loadUserData(){
        //User Name
        if let Str_FirstName = UserDefaults.standard.string(forKey: "DriverFirstName"),let Str_LastName = UserDefaults.standard.string(forKey: "DriverLasttName") {
            self.lbl_UserNameRef.text = Str_FirstName + " " +  Str_LastName
        }
        //Last Name
        //        if let Str_Email = UserDefaults.standard.string(forKey: "UserEmailID") {
        //            self.lbl_EmailRef.text = Str_Email
        //         }
        
        //User Image
        if let Str_UserImage = UserDefaults.standard.string(forKey: "DriverProfilepic") {
            self.imageview_ProfileRef.sd_setImage(with: URL(string: Str_UserImage), placeholderImage: UIImage(named: "UserPic"))
        }
        
        self.tableview_MenuSliderRef.reloadData()
    }
    
}

extension SideMenuViewController :UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuSliderTableViewCell", for: indexPath) as? MenuSliderTableViewCell else {return UITableViewCell()}
        cell.lbl_MenuSliderRef.text = arrayResponse[indexPath.row]
        cell.imageview_MenuSliderRef.image = arr_images[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrayResponse[indexPath.row] == "Logout" {
            self.callLogoutAction()
        } else if arrayResponse[indexPath.row] == "Home" {
            // dismiss(animated: true, completion: nil)
            self.movetonextvc(id: "DashBoardViewController", storyBordid: "DashBoard",animated:false)
        } else if arrayResponse[indexPath.row] == "Settings" {
            self.movetonextvc(id: "SettingsViewController", storyBordid: "Profile",animated:false)
        } else if arrayResponse[indexPath.row] == "Employee Guidelines" {
            let Storyboard : UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
            let nxtVC = Storyboard.instantiateViewController(withIdentifier: "TermsAndPrivacyViewController") as! TermsAndPrivacyViewController
            nxtVC.str_ActionComingFrom = "Employee Guidelines"
            self.navigationController?.pushViewController(nxtVC, animated:  true)
        } else if arrayResponse[indexPath.row] == "Weekly Payments" {
            self.movetonextvc(id: "WeeklyPaymentsViewController", storyBordid: "RidesHistory",animated:false)
        } else if arrayResponse[indexPath.row] == "Payment History" {
            self.movetonextvc(id: "PaymentHistoryViewController", storyBordid: "RidesHistory",animated:false)
        } else if arrayResponse[indexPath.row] == "Ride History" {
            self.movetonextvc(id: "RideHistoryViewController", storyBordid: "RidesHistory",animated:false) 
        } else if arrayResponse[indexPath.row] == "My Rewards" {
            self.movetonextvc(id: "ActivatedRewardProgramsViewController", storyBordid: "RidesHistory",animated:false)
        } else if arrayResponse[indexPath.row] == "Manage Partners" {
            self.movetonextvc(id: "ManagePartnersViewController", storyBordid: "RidesHistory",animated:false)
        } else if arrayResponse[indexPath.row] == "Driver Type" {
            self.movetonextvc(id: "DriverTypeViewController", storyBordid: "RidesHistory",animated:false)
        } else if arrayResponse[indexPath.row] == "Ride Reservations" {
            self.movetonextvc(id: "RideReservationsViewController", storyBordid: "OngoingRides",animated:false)
        } else if arrayResponse[indexPath.row] == "Accepted Rides" {
            self.movetonextvc(id: "AcceptedRidesInfoViewController", storyBordid: "OngoingRides",animated:false)
        }
    }
    
}

extension SideMenuViewController {
    func callLogoutAction() {
        let alertController = UIAlertController(title: kApptitle, message: I18n.LogoutAlert, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "Okay", style: .cancel, handler: { action in
            //self.logoutApiCalling()
            
            DispatchQueue.main.async { [self] in
                indicator.hideActivityIndicator()
                UserDefaults.standard.set("", forKey: "DriverLoginID")
                UserDefaults.standard.set("", forKey: "DriverEmailID")
                UserDefaults.standard.set("", forKey: "DriverFirstName")
                UserDefaults.standard.set("", forKey: "DriverLasttName")
                UserDefaults.standard.set("", forKey: "DriverMobilenumber")
                UserDefaults.standard.set("", forKey: "DriverRating")
                UserDefaults.standard.set(false, forKey: "IsUserLogined")
                UserDefaults.standard.set("", forKey: "DriverType")

                self.resetDefaults()
                if let delegate = UIApplication.shared.delegate as? AppDelegate {
                    delegate.MoveToLogin()
                }
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Logout Api Intigartion
    //    func logoutApiCalling(){
    //        guard let userID = UserDefaults.standard.string(forKey: "UserLoginID") else{return}
    //        indicator.showActivityIndicator()
    //        self.viewModel.requestForLogoutServices(perams: ["userid":userID]) { success, model, error in
    //            if success {
    //                DispatchQueue.main.async { [self] in
    //                    indicator.hideActivityIndicator()
    //                    UserDefaults.standard.set("", forKey: "UserLoginID")
    //                    UserDefaults.standard.set("", forKey: "RideRequestProcessingCheck")
    //                    UserDefaults.standard.set("", forKey: "CurrentNotificationTitle")
    //                    UserDefaults.standard.set("", forKey: "SelectedCardDetails")
    //                    self.resetDefaults()
    //                    if let delegate = UIApplication.shared.delegate as? AppDelegate {
    //                        delegate.MoveToLogin()
    //                    }
    //                }
    //            } else {
    //                DispatchQueue.main.async { [self] in
    //                    indicator.hideActivityIndicator()
    //                    self.showToast(message: error ?? "No Such Email Address Found.", font: .systemFont(ofSize: 12.0))
    //                }
    //            }
    //        }
    //    }
}
