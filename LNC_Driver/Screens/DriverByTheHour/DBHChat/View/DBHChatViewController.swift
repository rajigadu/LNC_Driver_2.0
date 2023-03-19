//
//  DBHChatViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 19/03/23.
//

import UIKit

class DBHChatViewController: UIViewController {

    @IBOutlet weak var tableRef: UITableView!
    @IBOutlet weak var msgTextRef: UITextField!
    var todayDate = ""
    var str_SendBtnCheckingStaus = ""
    var str_FirstTimeCalling = ""
    var resArr:[ChatDatar] = []
    var spinner = UIActivityIndicatorView()
        
    lazy var viewModel = {
        DBHChatViewModel()
    }()
    
    var vcCmgFrom = ""
    var userID = ""
    var keyValueStr = "driver"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        initialMethod()
        
        if vcCmgFrom != "AppDelegate" {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(backToMenu))
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backToDashboard))
            navigationController?.navigationBar.barTintColor = UIColor.black
        }
    }
    
    @objc func backToMenu() {
        self.navigateToSideMenu()
    }
    
    @objc func backToDashboard() {
        self.popToBackVC()
    }
    
    func initialMethod(){
        spinner = UIActivityIndicatorView(style: .large)
        spinner.stopAnimating()
        spinner.hidesWhenStopped = true
        spinner.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 60)
        tableRef.tableFooterView = spinner
        
        let currDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"
        todayDate = dateFormatter.string(from: currDate)
        self.title = "Chat"
        str_FirstTimeCalling = ""
        self.tableRef.backgroundColor = .darkGray
        self.tableRef.backgroundView?.backgroundColor = .darkGray
  
        self.chatMethodFromDriverToUser(userID: self.userID, withMessage: msgTextRef.text ?? "", withKeyValue: keyValueStr)
 
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        msgTextRef.resignFirstResponder()
    }
    
    @IBAction func sendBtnRef(_ sender: Any) {
        let currDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"
        todayDate = dateFormatter.string(from: currDate)
        
        if msgTextRef.text?.count ?? 0 <= 0 {
            return
        } else {
            str_SendBtnCheckingStaus = "SendBtnCheckingStaus"
                self.chatMethodFromDriverToUser(userID: self.userID, withMessage: msgTextRef.text ?? "", withKeyValue: keyValueStr)
        }
    }
}
extension DBHChatViewController {
    //MARK: - DriverToUserChattingAPI
    func chatMethodFromDriverToUser(userID: String, withMessage : String,withKeyValue: String) {
        guard let DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverToUserChattingAPIServices(perams: ["senderid":DriverLoginID,"recieverid":userID,"msg": withMessage,"keyvalue":withKeyValue,"date_time":todayDate]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    
                    if userData.status == "1" {
                        
                        if let responseData = userData.data as? [ChatDatar] {
                            self.resArr = responseData
                        }
                        if str_SendBtnCheckingStaus == "SendBtnCheckingStaus" {
                            self.msgTextRef.text = ""
                            str_SendBtnCheckingStaus = ""
                        }
                        self.tableRef.reloadData()
                        self.scrollToBottom()
                        if str_FirstTimeCalling == "" {
                            str_FirstTimeCalling = "Done"
                            self.tableRef.scrollToBottom(isAnimated: false)
                            
                        }else {
                            str_FirstTimeCalling = ""
                        }
                    } else {
                        self.showToast(message: userData.message ?? I18n.TryAgain, font: .systemFont(ofSize: 12.0))
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

extension DBHChatViewController :UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView, ArrayCount: resArr.count, numberOfsections: 1, data_MSG_Str: "Start communication now.")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as? ChatTableViewCell,let loginDriverID = UserDefaults.standard.string(forKey: "DriverLoginID") as? String else {return UITableViewCell()}
        cell.backgroundColor = .darkGray
        
        
        let typeOfUser = resArr[indexPath.row].sender ?? ""
        
        if typeOfUser == loginDriverID {
            cell.ResprofileImgRef.isHidden = true
            cell.ResbagRef.isHidden = true
            cell.ResdateRef.isHidden = true
            cell.ResmsgRef.isHidden = true
            
            //User Image
            if let Str_UserImage = resArr[indexPath.row].profileImageSender as? String {
                cell.SenprofileImgRef.sd_setImage(with: URL(string: API_URl.API_IMAGEBASE_URL +  Str_UserImage), placeholderImage: UIImage(named: "responderpic"))
            }
            cell.SenmsgRef.text = resArr[indexPath.row].mesage ?? ""
            var str_CurrentRideDateTime = resArr[indexPath.row].date_time ?? ""
            var str_CurrentRideDate = resArr[indexPath.row].date ?? ""
            
            if str_CurrentRideDateTime == "" {
                
                if str_CurrentRideDate == "" {
                    str_CurrentRideDate = ""
                }
                
                str_CurrentRideDateTime = str_CurrentRideDate
                let format = DateFormatter()
                format.timeZone = NSTimeZone.system
                format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let datell = format.date(from: str_CurrentRideDateTime)
                format.dateFormat = "MM-dd-yyyy hh:mm a"
                if let datestr = datell {
                    str_CurrentRideDateTime = format.string(from: datestr)
                }
            } else {
                let format = DateFormatter()
                format.timeZone = NSTimeZone.system
                format.dateFormat = "MM-dd-yyyy hh:mm a"
                let datell = format.date(from: str_CurrentRideDateTime)
                format.dateFormat = "MM-dd-yyyy hh:mm a"
                if let datestr = datell {
                    str_CurrentRideDateTime = format.string(from: datestr)
                }
            }
            cell.SendateRef.text = str_CurrentRideDateTime
            cell.SenprofileImgRef.isHidden = false
            cell.senBagRef.isHidden = false
            cell.SendateRef.isHidden = false
            cell.SenmsgRef.isHidden = false
            cell.SenprofileImgRef.layer.borderColor = UIColor.blue.cgColor
            cell.SenprofileImgRef.layer.borderWidth = 1
            cell.SenprofileImgRef.layer.cornerRadius = cell.ResprofileImgRef.frame.size.width/2
            cell.SenprofileImgRef.layer.masksToBounds = true
            
        } else {
            cell.SenprofileImgRef.isHidden = true
            cell.senBagRef.isHidden = true
            cell.SendateRef.isHidden = true
            cell.SenmsgRef.isHidden = true
            
            //User Image
            if let Str_UserImage = resArr[indexPath.row].profileImageReciever as? String {
                cell.ResprofileImgRef.sd_setImage(with: URL(string: API_URl.API_IMAGEBASE_URL + Str_UserImage), placeholderImage: UIImage(named: "responderpic"))
            }
            
            cell.ResmsgRef.text = resArr[indexPath.row].mesage ?? ""
            var str_CurrentRideDateTime = resArr[indexPath.row].date_time ?? ""
            var str_CurrentRideDate = resArr[indexPath.row].date ?? ""
            
            if str_CurrentRideDateTime == "" {
                
                if str_CurrentRideDate == "" {
                    str_CurrentRideDate = ""
                }
                
                str_CurrentRideDateTime = str_CurrentRideDate
                let format = DateFormatter()
                format.timeZone = NSTimeZone.system
                format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let datell = format.date(from: str_CurrentRideDateTime)
                format.dateFormat = "MM-dd-yyyy hh:mm a"
                if let datestr = datell {
                    str_CurrentRideDateTime = format.string(from: datestr)
                }
            } else {
                let format = DateFormatter()
                format.timeZone = NSTimeZone.system
                format.dateFormat = "MM-dd-yyyy hh:mm a"
                let datell = format.date(from: str_CurrentRideDateTime)
                format.dateFormat = "MM-dd-yyyy hh:mm a"
                if let datestr = datell {
                    str_CurrentRideDateTime = format.string(from: datestr)
                }
            }
            cell.ResdateRef.text = str_CurrentRideDateTime
            
            cell.ResprofileImgRef.isHidden = false
            cell.ResbagRef.isHidden = false
            cell.ResdateRef.isHidden = false
            cell.ResmsgRef.isHidden = false
            cell.ResprofileImgRef.layer.borderColor = UIColor.blue.cgColor
            cell.ResprofileImgRef.layer.borderWidth = 1
            cell.ResprofileImgRef.layer.cornerRadius = cell.ResprofileImgRef.frame.size.width/2;
            cell.ResprofileImgRef.layer.masksToBounds = true
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.resArr.count-1, section: 0)
            self.tableRef.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        
        let reloadDistance = CGFloat(30.0)
        if y > h + reloadDistance {
            print("fetch more data")
            //API Intigration
            self.initialMethod()
            spinner.startAnimating()
        }
    }
    
    enum scrollsTo {
        case top,bottom
    }
    
}
