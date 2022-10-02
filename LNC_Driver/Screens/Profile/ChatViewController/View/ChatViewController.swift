//
//  ChatViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 02/10/22.
//

import UIKit

class ChatViewController: UIViewController {

    var isTappedNotification = Bool()
    var recevierId = ""
    var str_ChatStatus = ""
    var userID = ""
    var str_ChatType = ""
    @IBOutlet weak var tableRef: UITableView!
    @IBOutlet weak var msgTextRef: UITextField!
    var str_CurrentRidePartnerID = ""
    var str_CurrentRideDriverID = ""
    var todayDate = ""
    var str_SendBtnCheckingStaus = ""
    var str_FirstTimeCalling = ""
    var resArr:[ChatDatar] = []

    var str_ChatMethod = ""
    
    lazy var viewModel = {
        ChatViewModel()
    }()

   var loginDriverID = ""
    var str_DerviceToken = ""
    var str_InRideDriverType = ""
    var keyValueStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let currDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"
        todayDate = dateFormatter.string(from: currDate)
        self.title = "Chat"
        str_FirstTimeCalling = ""
        loginDriverID = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        str_DerviceToken = UserDefaults.standard.string(forKey: "FCMDeviceToken") ?? "" ?? ""
        //Mark CHECKING CONDITION WHEN RIDE IS THERE IS DRIVER/PARTNER..............
        str_InRideDriverType = UserDefaults.standard.string(forKey: "InRideDriverType") ?? ""
//        if str_InRideDriverType == "" {
//            keyValueStr = "partner"
//        } else {
//            keyValueStr = "driver"
//        }
        
        var Chatsendertype = UserDefaults.standard.string(forKey: "ChatFromLaunchScreen") ?? ""
        if Chatsendertype == "PartnerFromLaunchScreen" {
            keyValueStr = "partner"
            self.str_CurrentRideDriverID = recevierId;
        } else if Chatsendertype == "DriverFromLaunchScreen" {
            keyValueStr = "driver"
            self.str_CurrentRidePartnerID = recevierId;
        } else {
            self.userID = recevierId
            keyValueStr = "driver"
        }
        
        self.tableRef.backgroundColor = .darkGray
        self.tableRef.backgroundView?.backgroundColor = .darkGray
        
        str_ChatMethod = UserDefaults.standard.string(forKey: "ChatFromLaunchScreen") ?? ""
        if str_ChatMethod == "UserFromLaunchScreen" {
            self.str_ChatType = "ToUser"
            UserDefaults.standard.removeObject(forKey: "UserFromLaunchScreen")
            UserDefaults.standard.set(nil, forKey: "UserFromLaunchScreen")
            
            //Call Ride API Here..
            self.driverCurrentRideDetailsAPI()
            self.str_ChatType = "ToDriver"
            UserDefaults.standard.removeObject(forKey: "PartnerFromLaunchScreen")
            UserDefaults.standard.set(nil, forKey: "PartnerFromLaunchScreen")
            //Call Ride API Here..
            self.partnerCurrentRideDetailsAPI()
        } else if str_ChatMethod == "DriverFromLaunchScreen" {
            self.str_ChatType = "ToPartner"
            UserDefaults.standard.removeObject(forKey: "DriverFromLaunchScreen")
            UserDefaults.standard.set(nil, forKey: "DriverFromLaunchScreen")
            //Call Ride API Here..
            self.driverCurrentRideDetailsAPI()
        } else {
            if self.str_ChatType == "ToUser" {
                self.chatMethodFromDriverToUser(ByUsingSenderId: loginDriverID, withReceiverId: self.userID, withMessage: "", withKeyValue:keyValueStr )
            } else if self.str_ChatType == "ToDriver" {
                self.chatMethodFromPartnerToDriver(ByUsingSenderId: loginDriverID, withReceiverId: self.str_CurrentRideDriverID, withMessage: "", withKeyValue: keyValueStr)
            } else if self.str_ChatType == "ToPartner" {
                self.chatMethodFromDriverToPartner(ByUsingSenderId: loginDriverID, withReceiverId: self.str_CurrentRidePartnerID, withMessage: "", withKeyValue: keyValueStr)
            }
        }
        
        
        
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

        if msgTextRef.text?.count ?? 0 > 0 {
            return
        } else {
            str_SendBtnCheckingStaus = "SendBtnCheckingStaus"
            if self.str_ChatType == "ToUser" {
                self.chatMethodFromDriverToUser(ByUsingSenderId: loginDriverID, withReceiverId: self.userID, withMessage: msgTextRef.text ?? "", withKeyValue: keyValueStr)
            } else if self.str_ChatType == "ToDriver" {
                self.chatMethodFromPartnerToDriver(ByUsingSenderId: loginDriverID, withReceiverId: self.str_CurrentRideDriverID, withMessage: msgTextRef.text ?? "", withKeyValue: keyValueStr)
            } else if self.str_ChatType == "ToPartner" {
                self.chatMethodFromDriverToPartner(ByUsingSenderId: loginDriverID, withReceiverId: self.str_CurrentRidePartnerID, withMessage: msgTextRef.text ?? "", withKeyValue: keyValueStr)
            }
        }
    }
}
extension ChatViewController {
    //MARK: - DriverToUserChattingAPI
    func chatMethodFromDriverToUser(ByUsingSenderId : String, withReceiverId : String, withMessage : String,withKeyValue: String) {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverToUserChattingAPIServices(perams: ["senderid":"255","recieverid":withReceiverId,"msg": withMessage,"keyvalue":withKeyValue,"date_time":todayDate]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let responseData = userData as? [ChatDatar] {
                        self.resArr = responseData
                    }
                    if str_SendBtnCheckingStaus == "SendBtnCheckingStaus" {
                        self.msgTextRef.text = ""
                        str_SendBtnCheckingStaus = ""
                    }
                    self.tableRef.reloadData()
                    if str_FirstTimeCalling == "" {
                        str_FirstTimeCalling = "Done"
                        self.tableRef.scrollToBottom(isAnimated: false)
                        
                    }else {
                        str_FirstTimeCalling = ""
                    }
                    
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
extension ChatViewController {
    //MARK: - DriverToPartnerChattingAPI
    func chatMethodFromDriverToPartner(ByUsingSenderId : String, withReceiverId : String, withMessage : String,withKeyValue: String) {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForDriverToPartnerChattingAPIServices(perams: ["senderid":"255","recieverid":withReceiverId,"msg": withMessage,"type":withKeyValue,"date_time":todayDate]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let responseData = userData as? [ChatDatar] {
                        self.resArr = responseData
                    }
                    if str_SendBtnCheckingStaus == "SendBtnCheckingStaus" {
                        self.msgTextRef.text = ""
                        str_SendBtnCheckingStaus = ""
                    }
                    self.tableRef.reloadData()
                    if str_FirstTimeCalling == "" {
                        str_FirstTimeCalling = "Done"
                        self.tableRef.scrollToBottom(isAnimated: false)
                    }else {
                        str_FirstTimeCalling = ""
                    }
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
extension ChatViewController {
    //MARK: - API_PARTNER_CHATWITHDRIVER_URL
    func chatMethodFromPartnerToDriver(ByUsingSenderId : String, withReceiverId : String, withMessage : String,withKeyValue: String) {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForPartnerToChatWithDriverAPIServices(perams: ["senderid":"255","recieverid":withReceiverId,"msg": withMessage,"type":withKeyValue,"date_time":todayDate]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if let responseData = userData as? [ChatDatar] {
                        self.resArr = responseData
                    }
                    if str_SendBtnCheckingStaus == "SendBtnCheckingStaus" {
                        self.msgTextRef.text = ""
                        str_SendBtnCheckingStaus = ""
                    }
                    self.tableRef.reloadData()
                    if str_FirstTimeCalling == "" {
                        str_FirstTimeCalling = "Done"
                        self.tableRef.scrollToBottom(isAnimated: false)
                    }else {
                        str_FirstTimeCalling = ""
                    }
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
extension ChatViewController {
    //MARK: - driverCurrentRideDetailsAPI
    func driverCurrentRideDetailsAPI() {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        self.viewModel.requestForDriverCurrentRideDetailsAPIServices(perams: ["driver_id":"255","devicetoken":str_DerviceToken,"device_type": "ios","type":str_InRideDriverType]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()

                    self.userID = userData.data?[0].userid ?? ""
                    if self.str_ChatType == "ToUser" {
                        self.chatMethodFromDriverToUser(ByUsingSenderId : loginDriverID,
                                                         withReceiverId : self.userID,
                                                            withMessage : msgTextRef.text ?? "",
                                                           withKeyValue : keyValueStr)
                    } else if self.str_ChatType == "ToPartner" {
                        self.chatMethodFromDriverToPartner(ByUsingSenderId: loginDriverID, withReceiverId: self.str_CurrentRidePartnerID, withMessage: msgTextRef.text ?? "", withKeyValue: keyValueStr)
                     } else if self.str_ChatType == "ToDriver" {
                        self.chatMethodFromDriverToPartner(ByUsingSenderId: loginDriverID, withReceiverId: self.str_CurrentRideDriverID, withMessage: msgTextRef.text ?? "", withKeyValue: keyValueStr)
                     }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if self.isTappedNotification == true {
                        self.isTappedNotification = false
                        
                        if self.str_ChatType == "ToUser" {
                            self.chatMethodFromDriverToUser(ByUsingSenderId: loginDriverID, withReceiverId: self.userID, withMessage: msgTextRef.text ?? "", withKeyValue: keyValueStr)
                        } else if self.str_ChatType == "ToPartner" {
                            self.chatMethodFromDriverToPartner(ByUsingSenderId: loginDriverID, withReceiverId: self.str_CurrentRidePartnerID, withMessage: msgTextRef.text ?? "", withKeyValue: keyValueStr)
                        } else if self.str_ChatType == "ToDriver" {
                            self.chatMethodFromPartnerToDriver(ByUsingSenderId: loginDriverID, withReceiverId: self.str_CurrentRideDriverID, withMessage: msgTextRef.text ?? "", withKeyValue: keyValueStr)
                        }
                        
                        
                    } else {
                        self.movetonextvc(id: "DashBoardViewController", storyBordid: "DashBoard", animated: true)
                    }
                }
             }
        }
    }
}
extension ChatViewController {
    //MARK: - partnerCurrentRideDetailsAPI
    func partnerCurrentRideDetailsAPI() {
        guard let str_userID = UserDefaults.standard.string(forKey: "DriverLoginID") else{return}
        indicator.showActivityIndicator()
        
        self.viewModel.requestForPartnerCurrentRideDetailsAPIServices(perams: ["driver_id":"255","devicetoken":str_DerviceToken,"device_type": "ios","type":str_InRideDriverType]) { success, model, error in
            if success, let userData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.userID = userData.data?[0].userid ?? ""
                    self.chatMethodFromPartnerToDriver(ByUsingSenderId: loginDriverID, withReceiverId: self.str_CurrentRideDriverID, withMessage: "", withKeyValue: keyValueStr)
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    if self.isTappedNotification == true {
                        self.isTappedNotification = false
                        
                        if self.str_ChatType == "ToUser" {
                            self.chatMethodFromDriverToUser(ByUsingSenderId: loginDriverID, withReceiverId: self.userID, withMessage: msgTextRef.text ?? "", withKeyValue: keyValueStr)
                        } else if self.str_ChatType == "ToPartner" {
                            self.chatMethodFromDriverToPartner(ByUsingSenderId: loginDriverID, withReceiverId: self.str_CurrentRidePartnerID, withMessage: msgTextRef.text ?? "", withKeyValue: keyValueStr)
                        } else if self.str_ChatType == "ToDriver" {
                            self.chatMethodFromPartnerToDriver(ByUsingSenderId: loginDriverID, withReceiverId: self.str_CurrentRideDriverID, withMessage: msgTextRef.text ?? "", withKeyValue: keyValueStr)
                        }
                        
                        
                    } else {
                        self.movetonextvc(id: "DashBoardViewController", storyBordid: "DashBoard", animated: true)
                    }
                }
             }
        }
    }
}

extension ChatViewController :UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView, ArrayCount: resArr.count, numberOfsections: 1, data_MSG_Str: "Start communication now.")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell: ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as? ChatTableViewCell else {return UITableViewCell()}
        
        cell.backgroundColor = .darkGray
        var typeOfUser = resArr[indexPath.row].sender ?? ""
        if typeOfUser == "255" {
            cell.ResprofileImgRef.isHidden = true
            cell.ResbagRef.isHidden = true
            cell.ResdateRef.isHidden = true
            cell.ResmsgRef.isHidden = true
            
            //User Image
            if let Str_UserImage = resArr[indexPath.row].profileImageSender as? String {
                cell.SenprofileImgRef.sd_setImage(with: URL(string: Str_UserImage), placeholderImage: UIImage(named: "responderpic"))
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
            if let Str_UserImage = resArr[indexPath.row].profileImageSender as? String {
                cell.ResprofileImgRef.sd_setImage(with: URL(string: Str_UserImage), placeholderImage: UIImage(named: "responderpic"))
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
    
    
}
