//
//  AvailableRewardProgramsListViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import UIKit

class AvailableRewardProgramsListViewController: UIViewController {

    @IBOutlet weak var tableViewRef: UITableView!
    
    var AvailableRewardProgramsList: [AvailableReward_Program] = []
    lazy var viewModel = {
        AvailableRewardProgramsListViewModel()
    }()
    
    var loginDriverIDStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
extension AvailableRewardProgramsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView, ArrayCount: AvailableRewardProgramsList.count, numberOfsections: 1, data_MSG_Str: "No data available")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AvailableRewardProgramsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AvailablerewardsListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AvailablerewardsListTableViewCell", for: indexPath) as? AvailablerewardsListTableViewCell else {return UITableViewCell()}
        
        var Str_rewardTitle = AvailableRewardProgramsList[indexPath.row].pname ?? ""
        cell.lbl_rewardTitle.text = "RewardTitle : " + Str_rewardTitle
        
        var Str_description = AvailableRewardProgramsList[indexPath.row].pdescription ?? ""
        cell.lbl_description.text = "Description : " + Str_description
        
        cell.btn_activateInfo.tag = indexPath.row
        cell.btn_activateInfo.addTarget(self, action: #selector(activateNowButtonClicked), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func activateNowButtonClicked(sender: UIButton) {
        var str_SelectedRideID = self.AvailableRewardProgramsList[sender.tag].id ?? ""
        self.ActivateRewardServices(program_id: str_SelectedRideID)
    }
    
    
}
extension AvailableRewardProgramsListViewController {
    
    //MARK: - Available Reward Programs
    func AvailableRewardProgramsListServices() {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForAvailableRewardProgramsListServices(perams: ["driver_id":"255"]) { success, model, error in
            if success, let GetBankDetailsModel = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let data = GetBankDetailsModel.data?[0].Program {
                        self.AvailableRewardProgramsList = data
                    }
//                    self.ary_PaymentHistoryInfo.reverse()
                    self.tableViewRef.reloadData()
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
extension AvailableRewardProgramsListViewController {
    
    //MARK: - Week Payment Details
    func ActivateRewardServices(program_id: String) {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForActivateRewardServices(perams: ["driver_id":"255","program_id":program_id]) { success, model, error in
            if success, let UserDetails = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.ShowAlertWithPush(message : UserDetails.message ?? "Successfully activated reward", className: "ActivatedRewardProgramsViewController", storyBoard: "RidesHistory", Animation: true)
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    //self.showToast(message: error ?? "No Such Email Address Found.", font: .systemFont(ofSize: 12.0))
                    self.ShowAlertWithPush(message : error ?? "Successfully activated reward", className: "ActivatedRewardProgramsViewController", storyBoard: "RidesHistory", Animation: true)
                }
             }
        }
    }
}



