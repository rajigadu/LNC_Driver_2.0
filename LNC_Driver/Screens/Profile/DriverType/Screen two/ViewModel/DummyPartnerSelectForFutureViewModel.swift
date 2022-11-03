//
//  DummyPartnerSelectForFutureViewModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 30/09/22.
//

import Foundation
import UIKit

class DummyPartnerSelectForFutureViewModel: NSObject {
    
    private var DummyPartnerSelectForFutureServices: LateNightChauffeursDriverServiceProtocol
    
    init(ApiService: LateNightChauffeursDriverServiceProtocol = ApiService()) {
        self.DummyPartnerSelectForFutureServices = ApiService
    }
    
    //MARK: - selectDriverTypeAPI
    func requestForDummyPartnerSelectForFutureServices(perams: Dictionary<String,String>, completion: @escaping (Bool, DriverTypeData?, String?) -> ()) {
        DummyPartnerSelectForFutureServices.requestForDummyPartnerSelectForFutureServices(perams){ success, model, error in
            if success, let DummyPartnerSelectForFuture = model {
                    completion(true, DummyPartnerSelectForFuture, nil)
            } else {
                completion(false, nil, error)
            }
        }
    }
}
