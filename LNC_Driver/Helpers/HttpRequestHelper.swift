//
//  HttpRequestHelper.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 08/09/22.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import UIKit
import Alamofire

enum HTTPHeaderFields {
    case application_json
    case application_x_www_form_urlencoded
    case none
}

class HttpRequestHelper {
    func GET(url: String, params: [String: String], httpHeader: HTTPHeaderFields, complete: @escaping (Bool, Data?) -> ()) {
        guard var components = URLComponents(string: url) else {
            print("Error: cannot create URLCompontents")
            return
        }
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print(" GET Method ")
        print(" \(url) ")
        print(" \(params) ")
        
        switch httpHeader {
        case .application_json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .application_x_www_form_urlencoded:
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        case .none: break
        }
        
        
        // .ephemeral prevent JSON from caching (They'll store in Ram and nothing on Disk)
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: problem calling GET")
                print(error!)
                complete(false, nil)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                complete(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                complete(false, nil)
                return
            }
            complete(true, data)
        }.resume()
    }
}

extension HttpRequestHelper {
    func POST(url: String, params: [String: String], httpHeader: HTTPHeaderFields, complete: @escaping (Bool, Data?) -> ()) {
        guard var components = URLComponents(string: url) else {
            print("Error: cannot create URLCompontents")
            return
        }
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        print(" GET Method ")
        print(" \(url) ")
        print(" \(params) ")
        
        switch httpHeader {
        case .application_json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .application_x_www_form_urlencoded:
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        case .none: break
        }
        
        
        // .ephemeral prevent JSON from caching (They'll store in Ram and nothing on Disk)
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: problem calling GET")
                print(error!)
                complete(false, nil)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                complete(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                complete(false, nil)
                return
            }
            complete(true, data)
        }.resume()
    }
}

extension HttpRequestHelper {
    //Profile Pic uplaod
    func uploadImagePOST(url: String, params: [String: Any], fileName: String, picImage: UIImage?, httpHeader: HTTPHeaderFields, profileStruct : uploadImage, completion: @escaping (Bool, ProfileUserData?) -> ()) {
        
        let boundary = "Boundary-\(UUID().uuidString)"
        guard let url = URL(string: url) else {
            return
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        switch httpHeader {
        case .application_json:
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        case .application_x_www_form_urlencoded:
            //urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            //urlRequest.setValue("multipart/form-data", forHTTPHeaderField: "Accept")
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
        case .none: break
        }
        
        // Now Execute
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key )
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key )
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            if profileStruct.imagetype == "Device" {
                if let imagePic = picImage {
                    if let datar = imagePic.jpegData(compressionQuality: 0.5)  {
                        multiPart.append(datar, withName: fileName, fileName: "\(fileName).jpg", mimeType: "image/jpg")
                    }
                }
            }
            else {
                if let ImageURL = URL(string : profileStruct.ImageUrl ?? "") {
                    //load some image
                    do {
                        let imageData = try Data(contentsOf: ImageURL)
                        multiPart.append(imageData, withName: fileName, fileName: "\(fileName).jpg", mimeType: "image/jpg")
                    } catch {
                        print("Unable to load image: \(error)")
                    }
                }
            }
        }, with: urlRequest)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    //let asJSON = try JSONSerialization.jsonObject(with: data)
                    let model = try JSONDecoder().decode(ProfileUserData.self, from: data)
                    // Handle as previously success
                    completion(true, model)
                } catch {
                    completion(false, nil)
                }
            case .failure(let error):
                // Handle as previously error
                print(error)
                completion(false, nil)
            }
        }
    }
}

extension HttpRequestHelper {
    func uploadEditVehicleImagePOST(url: String, params: [String: String],vehicle_image_name: String, vehicle_image: UIImage?,documents_image_name: String, documents_image: UIImage?,license_image_name: String, license_image: UIImage?,driver_abstract_name: String, driver_abstract: UIImage?, httpHeader: HTTPHeaderFields, vehicleImageStruct:uploadImage,documentImageStruct:uploadImage,licenseImageStruct:uploadImage,driverAbstactImageStruct:uploadImage, completion: @escaping (Bool, EditVehicleDataModel2?, String?) -> ()) {
        
        
        
        
        let boundary = "Boundary-\(UUID().uuidString)"
        guard let url = URL(string: url) else {
            return
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        switch httpHeader {
        case .application_json:
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        case .application_x_www_form_urlencoded:
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
            urlRequest.setValue("multipart/form-data", forHTTPHeaderField: "Accept")
        case .none: break
        }
        
        // Now Execute
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key )
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key )
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            // vehicle image
            if vehicle_image_name == "vehicle_image" {
                if vehicleImageStruct.imagetype == "Device" {
                    if let imagePic = vehicleImageStruct.Imagepic {
                        if let datar = imagePic.jpegData(compressionQuality: 0.5)  {
                            multiPart.append(datar, withName: "vehicle_image", fileName: "vehicle_image.jpg", mimeType: "image/jpg")
                        }
                    }
                } else if vehicleImageStruct.imagetype == "URL" {
                    if let ImageURL = URL(string : vehicleImageStruct.ImageUrl ?? "") {
                        //load some image
                        do {
                            let imageData = try Data(contentsOf: ImageURL)
                            multiPart.append(imageData, withName: "vehicle_image", fileName: "vehicle_image.jpg", mimeType: "image/jpg")
                        } catch {
                            print("Unable to load image: \(error)")
                        }
                    }
                }
                
                
                
                // documents image
                if documents_image_name == "documents_image" {
                    if documentImageStruct.imagetype == "Device" {
                        if let imagePic = documentImageStruct.Imagepic {
                            if let data = imagePic.jpegData(compressionQuality: 0.5)  {
                                multiPart.append(data, withName: "documents_image", fileName: "documents_image.jpg", mimeType: "image/jpg")
                            }
                        }
                    } else if documentImageStruct.imagetype == "URL" {
                        if let ImageURL = URL(string : documentImageStruct.ImageUrl ?? "") {
                            //load some image
                            do {
                                let imageData = try Data(contentsOf: ImageURL)
                                multiPart.append(imageData, withName: "documents_image", fileName: "documents_image.jpg", mimeType: "image/jpg")
                            } catch {
                                print("Unable to load image: \(error)")
                            }
                        }
                    }
                    //                    // license image
                    if license_image_name == "license_image" {
                        if licenseImageStruct.imagetype == "Device" {
                            if let imagePic = license_image {
                                if let data = imagePic.jpegData(compressionQuality: 0.5)  {
                                    multiPart.append(data, withName: "license_image", fileName: "license_image.jpg", mimeType: "image/jpg")
                                }
                            }
                        } else if licenseImageStruct.imagetype == "URL" {
                            if let ImageURL = URL(string : licenseImageStruct.ImageUrl ?? "") {
                                //load some image
                                do {
                                    let imageData = try Data(contentsOf: ImageURL)
                                    multiPart.append(imageData, withName: "license_image", fileName: "license_image.jpg", mimeType: "image/jpg")
                                } catch {
                                    print("Unable to load image: \(error)")
                                }
                            }
                        }
                        //                        // driver abstract
                        if driver_abstract_name == "driver_abstract" {
                            if driverAbstactImageStruct.imagetype == "Device" {
                                if let imagePic = driver_abstract {
                                    if let data = imagePic.jpegData(compressionQuality: 0.5)  {
                                        multiPart.append(data, withName: "driver_abstract", fileName: "driver_abstract.jpg", mimeType: "image/jpg")
                                    }
                                }
                            } else if driverAbstactImageStruct.imagetype == "URL" {
                                if let ImageURL = URL(string : driverAbstactImageStruct.ImageUrl ?? "") {
                                    //load some image
                                    do {
                                        let imageData = try Data(contentsOf: ImageURL)
                                        multiPart.append(imageData, withName: "driver_abstract", fileName: "driver_abstract.jpg", mimeType: "image/jpg")
                                    } catch {
                                        print("Unable to load image: \(error)")
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
            
        }, with: urlRequest)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    //let asJSON = try JSONSerialization.jsonObject(with: data)
                    let model = try JSONDecoder().decode(EditVehicleDataModel2.self, from: data)
                    // Handle as previously success
                    completion(true, model, "")
                } catch {
                    completion(false, nil,I18n.ModelDecodeErrorString)
                }
            case .failure(let error):
                // Handle as previously error
                print(error)
                completion(false, nil, I18n.ModelDecodeErrorString)
            }
        }
    }
}
extension HttpRequestHelper {
    func uploadImagePOSTForRegistartion(url: String, params: [String: Any],peramsModel:registartionStruct, profilepic_name: String, profilepic: UIImage?,vehicle_image_name: String, vehicle_image: UIImage?,documents_image_name: String, documents_image: UIImage?,license_image_name: String, license_image: UIImage?,driver_abstract_name: String, driver_abstract: UIImage?, httpHeader: HTTPHeaderFields, complete: @escaping (Bool, RegistrationUserData?) -> ()) {
        
        let boundary = "Boundary-\(UUID().uuidString)"
        guard let url = URL(string: url) else {
            return
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        switch httpHeader {
        case .application_json:
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        case .application_x_www_form_urlencoded:
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.setValue("multipart/form-data", forHTTPHeaderField: "Accept")
        case .none: break
        }
        
        guard let str_UserFirstName = peramsModel.str_fname else {return}
        guard let str_UserLastName = peramsModel.str_lname else {return}
        guard let str_UserEmail = peramsModel.str_email else {return}
        guard let str_UserMobilenumber = peramsModel.str_mobile else {return}
        guard let str_Userpassword = peramsModel.str_password else {return}
        guard let str_UserAdddress = peramsModel.str_address else {return}
        guard let str_UserVtype = peramsModel.str_vtype else {return}
        guard let str_UserVModel = peramsModel.str_vmodel else {return}
        guard let str_UserMakingYear = peramsModel.str_makingyear else {return}

        
        let parameters = [
            [
                "key": "json",
                "value": "\"{\\\"address\\\":\\\"\(str_UserAdddress)\\\",\\\"mobile\\\":\\\"\(str_UserMobilenumber)\\\",\\\"lname\\\":\\\"\(str_UserLastName)\\\",\\\"email\\\":\\\"\(str_UserEmail)\\\",\\\"vmodel\\\":\\\"\(str_UserVModel)\\\",\\\"makingyear\\\":\\\"\(str_UserMakingYear)\\\",\\\"fname\\\":\\\"\(str_UserFirstName)\\\",\\\"password\\\":\\\"\(str_Userpassword)\\\",\\\"vtype\\\":\\\"\(str_UserVtype)\\\"}\"",
                "type": "text"
            ]] as [[String : Any]]
        
        var body = ""
        var error: Error? = nil
        
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)
        
        
        // Now Execute
        AF.upload(multipartFormData: { multiPart in
            
            for param in parameters {
                if param["disabled"] == nil {
                    let paramName = param["key"]
                    if let paramType = param["type"] as? String {
                        if paramType == "text" {
                            if let paramValue = param["value"] as? String {
                                //body += "\r\n\r\n\(paramValue)\r\n"
                                multiPart.append(paramValue.data(using: .utf8)!, withName: "json")
                            }
                        }
                    }
                }
            }
            for (key, value) in params {
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key )
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            // vehicle image
            if profilepic_name == "profilepic" {
                if let imagePic = profilepic {
                    if let datar = imagePic.jpegData(compressionQuality: 0.5)  {
                        multiPart.append(datar, withName: "profilepic", fileName: "profilepic.jpg", mimeType: "image/jpg")
                    }
                }
                
                // vehicle image
                if vehicle_image_name == "vehicle_image" {
                    if let imagePic = vehicle_image {
                        if let datar = imagePic.jpegData(compressionQuality: 0.5)  {
                            multiPart.append(datar, withName: "vehicle_image", fileName: "vehicle_image.jpg", mimeType: "image/jpg")
                        }
                    }
                    
                    // documents image
                    if documents_image_name == "documents_image" {
                        if let imagePic = documents_image {
                            if let data = imagePic.jpegData(compressionQuality: 0.5)  {
                                multiPart.append(data, withName: "documents_image", fileName: "documents_image.jpg", mimeType: "image/jpg")
                            }
                        }
                        
                        //                    // license image
                        if license_image_name == "license_image" {
                            if let imagePic = license_image {
                                if let data = imagePic.jpegData(compressionQuality: 0.5)  {
                                    multiPart.append(data, withName: "license_image", fileName: "license_image.jpg", mimeType: "image/jpg")
                                }
                            }
                            
                            //                        // driver abstract
                            if driver_abstract_name == "driver_abstract" {
                                if let imagePic = driver_abstract {
                                    if let data = imagePic.jpegData(compressionQuality: 0.5)  {
                                        multiPart.append(data, withName: "driver_abstract", fileName: "driver_abstract.jpg", mimeType: "image/jpg")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }, with: urlRequest)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    //let asJSON = try JSONSerialization.jsonObject(with: data)
                    let model = try JSONDecoder().decode(RegistrationUserData.self, from: data)
                    // Handle as previously success
                    complete(true, model)
                } catch {
                    complete(false, nil)
                }
            case .failure(let error):
                // Handle as previously error
                print(error)
                complete(false, nil)
            }
        }
    }
}
extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
    
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

/*
 let parameters = [
 [
 "key": "json",
 "value": "\"{\\\"address\\\":\\\"4-A, Dr, J J Nagar, Mogappair, Chennai, Tamil Nadu 600037, India\\\",\\\"mobile\\\":\\\"1234567890\\\",\\\"lname\\\":\\\"lull\\\",\\\"email\\\":\\\"rajeshhh@anaad.net\\\",\\\"vmodel\\\":\\\"yfhgvjbn,m\\\",\\\"makingyear\\\":\\\"fygjhbk\\\",\\\"fname\\\":\\\"kgjkgkj\\\",\\\"password\\\":\\\"123\\\",\\\"vtype\\\":\\\"fghvjbm,\\\"}\"",
 "type": "text"
 ]] as [[String : Any]]
 
 let boundary = "Boundary-\(UUID().uuidString)"
 var body = ""
 var error: Error? = nil
 for param in parameters {
 if param["disabled"] == nil {
 let paramName = param["key"]!
 body += "--\(boundary)\r\n"
 body += "Content-Disposition:form-data; name=\"\(paramName)\""
 if param["contentType"] != nil {
 body += "\r\nContent-Type: \(param["contentType"] as! String)"
 }
 let paramType = param["type"] as! String
 if paramType == "text" {
 let paramValue = param["value"] as! String
 body += "\r\n\r\n\(paramValue)\r\n"
 } else {
 let paramSrc = param["src"] as! String
 let fileData = try NSData(contentsOfFile:paramSrc, options:[]) as Data
 let fileContent = String(data: fileData, encoding: .utf8)!
 body += "; filename=\"\(paramSrc)\"\r\n"
 + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
 }
 }
 }
 body += "--\(boundary)--\r\n";
 let postData = body.data(using: .utf8)
 
 var request = URLRequest(url: URL(string: "https://lnc.latenightchauffeurs.com/lnc-administrator/ios/driver/signup.php")!,timeoutInterval: Double.infinity)
 request.addValue("PHPSESSID=me830a0taser7aoiq1aeogm0v0", forHTTPHeaderField: "Cookie")
 request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
 
 request.httpMethod = "POST"
 request.httpBody = postData
 
 let task = URLSession.shared.dataTask(with: request) { data, response, error in
 guard let data = data else {
 print(String(describing: error))
 semaphore.signal()
 return
 }
 print(String(data: data, encoding: .utf8)!)
 semaphore.signal()
 }
 
 task.resume()
 semaphore.wait()
 */
