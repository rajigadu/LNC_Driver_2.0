//
//  AddVehicleInfoModel.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 15/09/22.
//

import Foundation
import UIKit

typealias GetVehicleData = GetVehicleDataModel

struct GetVehicleDataModel : Codable {
    let loginStatus : String?
    let message : String?
    let userData : GetVehicleDataDatar?
    enum CodingKeys: String, CodingKey {
        
        case loginStatus = "status"
        case message = "msg"
        case userData = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        loginStatus = try values.decodeIfPresent(String.self, forKey: .loginStatus)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userData = try values.decodeIfPresent(GetVehicleDataDatar.self, forKey: .userData)
    }
}

struct GetVehicleDataDatar : Codable {
    
    let vehicle_type: String?
    let vehicle_model: String?
    let vehile_making_year: String?
    let vehicle_image: String?
    let license_image: String?
    let document_image: String?
    let abstract_image: String?
    
    enum CodingKeys: String, CodingKey {
        
        case vehicle_type = "vehicle_type"
        case vehicle_model = "vehicle_model"
        case vehile_making_year = "vehile_making_year"
        case vehicle_image = "vehicle_image"
        case license_image = "license_image"
        case document_image = "document_image"
        case abstract_image = "abstract_image"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        vehicle_type = try values.decodeIfPresent(String.self, forKey: .vehicle_type)
        vehicle_model = try values.decodeIfPresent(String.self, forKey: .vehicle_model)
        vehile_making_year = try values.decodeIfPresent(String.self, forKey: .vehile_making_year)
        vehicle_image = try values.decodeIfPresent(String.self, forKey: .vehicle_image)
        license_image = try values.decodeIfPresent(String.self, forKey: .license_image)
        document_image = try values.decodeIfPresent(String.self, forKey: .document_image)
        abstract_image = try values.decodeIfPresent(String.self, forKey: .abstract_image)
    }
}

struct EditVehicleDataModel2 : Codable {
    let message : String?
    let data : [GetVehicleDataDatar2]?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case data = "data"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([GetVehicleDataDatar2].self, forKey: .data)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
struct GetVehicleDataDatar2 : Codable {
    let vehicle_type : String?
    let vehicle_model : String?
    let vehile_making_year : String?
    let vehicle_image : String?
    let document_image : String?
    let license_image : String?
    let abstract_image : String?

    enum CodingKeys: String, CodingKey {

        case vehicle_type = "vehicle_type"
        case vehicle_model = "vehicle_model"
        case vehile_making_year = "vehile_making_year"
        case vehicle_image = "vehicle_image"
        case document_image = "document_image"
        case license_image = "license_image"
        case abstract_image = "abstract_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        vehicle_type = try values.decodeIfPresent(String.self, forKey: .vehicle_type)
        vehicle_model = try values.decodeIfPresent(String.self, forKey: .vehicle_model)
        vehile_making_year = try values.decodeIfPresent(String.self, forKey: .vehile_making_year)
        vehicle_image = try values.decodeIfPresent(String.self, forKey: .vehicle_image)
        document_image = try values.decodeIfPresent(String.self, forKey: .document_image)
        license_image = try values.decodeIfPresent(String.self, forKey: .license_image)
        abstract_image = try values.decodeIfPresent(String.self, forKey: .abstract_image)
    }

}

struct uploadImage {
    var Imagepic: UIImage?
    var ImageName : String?
    var imagetype : String? // Device one
    var ImageUrl : String?
 }
