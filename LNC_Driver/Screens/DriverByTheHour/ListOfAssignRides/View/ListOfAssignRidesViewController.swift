//
//  ListOfAssignRidesViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 16/03/23.
//

import UIKit

class ListOfAssignRidesViewController: UIViewController {

    @IBOutlet weak var tableview_ListOfAssignRidesList: UITableView!
    var listofAssginRides: [ListOfAssignRidesDataR] = []
    lazy var viewModel = {
       return ListOfAssignRidesViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.driverGetAssignRidesListAPI()
        // Do any additional setup after loading the view.
    }
    @IBAction func openMenuBtnref(_ sender: Any) {
        self.navigateToSideMenu()
    }

}
extension ListOfAssignRidesViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
            return numberOfSections_nodata(in: tableView, ArrayCount: listofAssginRides.count, numberOfsections: 1, data_MSG_Str: "No records found!")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listofAssginRides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rideInfo = listofAssginRides[indexPath.row] as? ListOfAssignRidesDataR, let cell : AssignRidesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AssignRidesTableViewCell") as? AssignRidesTableViewCell else {return UITableViewCell()}
        
        // Created Date
        if let createdDate = rideInfo.otherdate, let createdTime = rideInfo.time {
            //cell.createdDateLabel.text = createdDate + " " + createdTime
            
            let AttributeStr2 = "Date/Time : " + createdDate + " " + createdTime
            let attrStri2 = NSMutableAttributedString.init(string:AttributeStr2)
            
            var nsRange2 = NSString(string: AttributeStr2).range(of: "Date/Time :", options: String.CompareOptions.caseInsensitive)
            attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange2)
            
            cell.createdDateLabel.attributedText = attrStri2

        }
        //Pickup Address
        if let pickUpAddress = rideInfo.pickup_address {
            //cell.pickUpAddressLabel.text = pickUpAddress
            
            let AttributeStr2 = "Pickup : " + pickUpAddress
            let attrStri2 = NSMutableAttributedString.init(string:AttributeStr2)
            
            var nsRange2 = NSString(string: AttributeStr2).range(of: "Pickup :", options: String.CompareOptions.caseInsensitive)
            attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange2)
            cell.pickUpAddressLabel.attributedText = attrStri2
        }
        //Notes
        if let note = rideInfo.notes {
            //cell.notesLabel.text = note
            let AttributeStr2 = "Notes : " + note
            let attrStri2 = NSMutableAttributedString.init(string:AttributeStr2)
            
            var nsRange2 = NSString(string: AttributeStr2).range(of: "Notes :", options: String.CompareOptions.caseInsensitive)
            attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(red: 35.0/255.0, green: 159.0/255.0, blue: 98.0/255, alpha: 1.0)], range: nsRange2)
            cell.notesLabel.attributedText = attrStri2

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rideInfo = listofAssginRides[indexPath.row] as? ListOfAssignRidesDataR else {return}
        let Storyboard : UIStoryboard = UIStoryboard(name: "DriverByTheHour", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "DBHRidePreviewViewController") as! DBHRidePreviewViewController
        nxtVC.assignRideDetails = rideInfo
        self.navigationController?.pushViewController(nxtVC, animated: true)
    }
    
}
extension ListOfAssignRidesViewController {
    func driverGetAssignRidesListAPI() {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
       
        self.viewModel.requestForDBHAssignRideListAPIServices(perams: ["driver_id":DriverLoginID]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if userData.status == "1" {
                        if let responseData = userData.data {
                            self.listofAssginRides = responseData
                        }
                        self.tableview_ListOfAssignRidesList.reloadData()
                    } else {
                        //self.showToast(message: userData.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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
