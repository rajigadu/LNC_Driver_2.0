//
//  HistoryOfRewardProgramsViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import UIKit

class HistoryOfRewardProgramsViewController: UIViewController {

    @IBOutlet weak var tblViewRef: UITableView!
    var ary_HistoryOfRewardInfo: [HistoryOfRewardProgramsDatar] = []
    var loginDriverIDStr = ""
    lazy var viewModel = {
        HistoryOfRewardProgramsViewModel()
    }()
    
    var str_driver_time = ""
    var rewardProgId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rewards History"
        self.tblViewRef.estimatedRowHeight = 1000
        self.tblViewRef.rowHeight = UITableView.automaticDimension
        
        loginDriverIDStr = "255"
        //UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        // Do any additional setup after loading the view.
        self.HistoryOfRewardProgramsAPI()
    }
    


}
extension HistoryOfRewardProgramsViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView, ArrayCount: ary_HistoryOfRewardInfo.count, numberOfsections: 1, data_MSG_Str: "No data available")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary_HistoryOfRewardInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:RewardsHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RewardsHistoryTableViewCell", for: indexPath) as? RewardsHistoryTableViewCell else {return UITableViewCell()}
        let str_CurrentRideDate = ary_HistoryOfRewardInfo[indexPath.row].otherdate ?? ""
        let str_CurrentRideTime = ary_HistoryOfRewardInfo[indexPath.row].time ?? ""
        let str_pickup_address = ary_HistoryOfRewardInfo[indexPath.row].pickup_address ?? ""
        let str_drop_address = ary_HistoryOfRewardInfo[indexPath.row].drop_address ?? ""
        let str_distance = ary_HistoryOfRewardInfo[indexPath.row].distance ?? ""
        let str_point = ary_HistoryOfRewardInfo[indexPath.row].point ?? ""
        
        cell.lbl_dateTime.text = "Date & time : " + str_CurrentRideDate + " " + str_CurrentRideTime
        cell.lbl_pickup.text = "PickUp : " + str_pickup_address
        cell.lbl_dropoff.text = "Drop off: " + str_drop_address
        cell.lbl_miles.text = "Miles : " + str_distance
        cell.lbl_rewardpoints.text = "Reward Points : " + str_point

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

extension HistoryOfRewardProgramsViewController {
    
    //MARK: - History Of Reward Programs
    func HistoryOfRewardProgramsAPI() {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForHistoryOfRewardProgramsServices(perams: ["driver_id":"255","program_id":rewardProgId,"driver_time":str_driver_time]) { success, model, error in
            if success, let GetBankDetailsModel = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let data = GetBankDetailsModel.data {
                        self.ary_HistoryOfRewardInfo = data
                    }
//                    self.ary_PaymentHistoryInfo.reverse()
                    self.tblViewRef.reloadData()
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



