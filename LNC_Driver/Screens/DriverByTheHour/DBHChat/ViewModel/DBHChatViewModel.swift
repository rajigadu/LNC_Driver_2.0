//
//  DBHChatViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 19/03/23.
//

import Foundation
import UIKit

class DBHChatViewModel: NSObject {
    
    private var DBHChatServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.DBHChatServices = ApiService
    }
    
    //MARK: - DriverToUserChattingAPI
    func requestForDriverToUserChattingAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ChatData?, String?) -> ()) {
        DBHChatServices.requestForDBHDriverToUserChattingAPIServices(perams){ success, model, error in
            if success, let userData = model {
                completion(true, userData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
