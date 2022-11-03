//
//  ActivatedRewardProgramsViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 29/09/22.
//

import UIKit

class ActivatedRewardProgramsViewController: UIViewController {

    @IBOutlet weak var tblViewRef: UITableView!
    var ary_ActivatedRewardInfo: [ActivatedRewardProgramsDatar] = []
    lazy var viewModel = {
        ActivatedRewardProgramsViewModel()
    }()
    
    var loginDriverIDStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Rewards"
        self.tblViewRef.estimatedRowHeight = 1000
        self.tblViewRef.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
        loginDriverIDStr = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        
        self.ActivatedRewardProgramsAPI()
    }
    
    @IBAction func openMenuBntref(_ sender: Any) {
        self.navigateToSideMenu()
    }
    
}

extension ActivatedRewardProgramsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView, ArrayCount: ary_ActivatedRewardInfo.count, numberOfsections: 1, data_MSG_Str: "No data available")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary_ActivatedRewardInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:ActiveRewardsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ActiveRewardsTableViewCell", for: indexPath) as? ActiveRewardsTableViewCell else {return UITableViewCell()}
        let targetPoints = ary_ActivatedRewardInfo[indexPath.row].target ?? ""
        let bonusPoints = ary_ActivatedRewardInfo[indexPath.row].bonus ?? ""
        let bonusEarn = ary_ActivatedRewardInfo[indexPath.row].total ?? ""
        let ProgramTitle = ary_ActivatedRewardInfo[indexPath.row].pname ?? ""
        let craeted_date = ary_ActivatedRewardInfo[indexPath.row].craeted_date ?? ""
        
        cell.lbl_dateTime.text = "Program Created Date: " + craeted_date
        
        let AttributeStr = "Program Name : " + ProgramTitle
        let attrStri = NSMutableAttributedString.init(string:AttributeStr)
        let nsRange = NSString(string: AttributeStr).range(of: "Program Name :", options: String.CompareOptions.caseInsensitive)
        attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], range: nsRange)
        cell.lbl_progTitle.attributedText = attrStri

        let AttributeStr1 = "Target Points : " + targetPoints
        let attrStri1 = NSMutableAttributedString.init(string:AttributeStr1)
        let nsRange1 = NSString(string: AttributeStr1).range(of: "Target Points :", options: String.CompareOptions.caseInsensitive)
        attrStri1.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], range: nsRange1)
        cell.lbl_totalPoints.attributedText = attrStri1

        let AttributeStr2 = "Bonus Amount : " + bonusPoints
        let attrStri2 = NSMutableAttributedString.init(string:AttributeStr2)
        let nsRange2 = NSString(string: AttributeStr2).range(of: "Bonus Amount :", options: String.CompareOptions.caseInsensitive)
        attrStri2.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], range: nsRange2)
        cell.lbl_status.attributedText = attrStri2

        let AttributeStr3 = "Your Total Earnings: " + bonusEarn
        let attrStri3 = NSMutableAttributedString.init(string:AttributeStr3)
        let nsRange3 = NSString(string: AttributeStr3).range(of: "Your Total Earnings :", options: String.CompareOptions.caseInsensitive)
        attrStri3.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], range: nsRange3)
        cell.lbl_totalEarnpointsref.attributedText = attrStri3

        cell.btn_ViewInfo.tag = indexPath.row
        cell.btn_ViewInfo.addTarget(self, action: #selector(viewInfoButtonClicked), for: .touchUpInside)

        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    @objc func viewInfoButtonClicked(sender: UIButton) {
        let str_SelectedrewardID = ary_ActivatedRewardInfo[sender.tag].id ?? ""
        let str_driver_time = ary_ActivatedRewardInfo[sender.tag].driver_time ?? ""
        
        let Storyboard : UIStoryboard = UIStoryboard(name: "RidesHistory", bundle: nil)
        let nxtVC = Storyboard.instantiateViewController(withIdentifier: "HistoryOfRewardProgramsViewController") as! HistoryOfRewardProgramsViewController
        nxtVC.rewardProgId = str_SelectedrewardID
        nxtVC.str_driver_time = str_driver_time
        self.navigationController?.pushViewController(nxtVC, animated:true)

    }
    
}
extension ActivatedRewardProgramsViewController {
    
    //MARK: - Activated Reward Programs
    func ActivatedRewardProgramsAPI() {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForActivatedRewardProgramsServices(perams: ["driver_id":DriverLoginID]) { success, model, error in
            if success, let ActivatedRewardProgram = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if ActivatedRewardProgram.status == "1" {
                        if let data = ActivatedRewardProgram.data {
                            self.ary_ActivatedRewardInfo = data
                        }
                        self.tblViewRef.reloadData()
                    } else {
                        self.showToast(message: ActivatedRewardProgram.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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



