//
//  ChatViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 02/10/22.
//

import Foundation
import UIKit

class ChatViewModel: NSObject {
    
    private var ChatServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.ChatServices = ApiService
    }
    
    //MARK: - DriverToUserChattingAPI
    func requestForDriverToUserChattingAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ChatData?, String?) -> ()) {
        ChatServices.requestForDriverToUserChattingAPIServices(perams){ success, model, error in
            if success, let userData = model {
                completion(true, userData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - DriverToPartnerChattingAPI
    func requestForDriverToPartnerChattingAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ChatData?, String?) -> ()) {
        ChatServices.requestForDriverToPartnerChattingAPIServices(perams){ success, model, error in
            if success, let userData = model {
                completion(true, userData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: -  PARTNERTOCHATWITHDRIVERApi
    func requestForPartnerToChatWithDriverAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ChatData?, String?) -> ()) {
        ChatServices.requestForPartnerToChatWithDriverAPIServices(perams){ success, model, error in
            if success, let userData = model {
                completion(true, userData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: -  driverCurrentRideDetailsAPI
    func requestForDriverCurrentRideDetailsAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ChatDetailsData?, String?) -> ()) {
        ChatServices.requestForDriverCurrentRideDetailsAPIServices(perams){ success, model, error in
            if success, let userData = model {
                completion(true, userData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    //MARK: - partnerCurrentRideDetailsAPI
    func requestForPartnerCurrentRideDetailsAPIServices(perams: Dictionary<String,String>, completion: @escaping (Bool, ChatDetailsData?, String?) -> ()) {
        ChatServices.requestForPartnerCurrentRideDetailsAPIServices(perams){ success, model, error in
            if success, let userData = model {
                completion(true, userData, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
