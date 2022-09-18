//
//  Imageextension.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 16/09/22.
//

import Foundation

enum ImageFormat: RawRepresentable {
  case unknown, png, jpeg, gif, tiff1, tiff2
  
  init?(rawValue: [UInt8]) {
    switch rawValue {
    case [0x89]: self = .png
    case [0xFF]: self = .jpeg
    case [0x47]: self = .gif
    case [0x49]: self = .tiff1
    case [0x4D]: self = .tiff2
    default: return nil
    }
  }
  
  var rawValue: [UInt8] {
    switch self {
    case .png: return [0x89]
    case .jpeg: return [0xFF]
    case .gif: return [0x47]
    case .tiff1: return [0x49]
    case .tiff2: return [0x4D]
    case .unknown: return []
    }
  }
}


extension NSData {
  var imageFormat: ImageFormat {
    var buffer = [UInt8](repeating: 0, count: 1)
    self.getBytes(&buffer, range: NSRange(location: 0,length: 1))
    return ImageFormat(rawValue: buffer) ?? .unknown
  }
}

extension Data {
  var imageFormat: ImageFormat {
    (self as NSData?)?.imageFormat ?? .unknown
  }
}
