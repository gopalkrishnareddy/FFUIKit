//
//  UIDevice+Hardware.swift
//  FFUIKit
//
//  Created by Florian Friedrich on 17.1.15.
//  Copyright (c) 2015 Florian Friedrich. All rights reserved.
//

import FFUIKit

public extension UIDevice {
    private var platformNameMapping: [String: String] {
        return [
            "iPhone1,1": "iPhone 1G",
            "iPhone1,2": "iPhone 3G",
            "iPhone2,1": "iPhone 3GS",
            "iPhone3,1": "iPhone 4",
            "iPhone3,3": "iPhone 4 Verizon",
            "iPhone4,1": "iPhone 4S",
            "iPhone5,1": "iPhone 5 (GSM)",
            "iPhone5,2": "iPhone 5 (GSM+CDMA)",
            "iPhone5,3": "iPhone 5c (GSM)",
            "iPhone5,4": "iPhone 5c (GSM+CDMA)",
            "iPhone6,1": "iPhone 5s (GSM)",
            "iPhone6,2": "iPhone 5s (GSM+CDMA)",
            "iPhone7,1": "iPhone 6 Plus",
            "iPhone7,2": "iPhone 6",
            
            "iPod1,1"  : "iPod Touch 1G",
            "iPod2,1"  : "iPod Touch 2G",
            "iPod3,1"  : "iPod Touch 3G",
            "iPod4,1"  : "iPod Touch 4G",
            "iPod5,1"  : "iPod Touch 5G",
            
            "iPad1,1"  : "iPad",
            "iPad2,1"  : "iPad 2 (WiFi)",
            "iPad2,2"  : "iPad 2 (GSM)",
            "iPad2,3"  : "iPad 2 (CDMA)",
            "iPad2,4"  : "iPad 2 (WiFi)",
            "iPad2,5"  : "iPad Mini (WiFi)",
            "iPad2,6"  : "iPad Mini (GSM)",
            "iPad2,7"  : "iPad Mini (GSM+CDMA)",
            "iPad3,1"  : "iPad 3 (WiFi)",
            "iPad3,2"  : "iPad 3 (GSM+CDMA)",
            "iPad3,3"  : "iPad 3 (GSM)",
            "iPad3,4"  : "iPad 4 (WiFi)",
            "iPad3,5"  : "iPad 4 (GSM)",
            "iPad3,6"  : "iPad 4 (GSM+CDMA)",
            "iPad4,1"  : "iPad Air (WiFi)",
            "iPad4,2"  : "iPad Air (Cellular)",
            "iPad4,3"  : "iPad Air",
            "iPad4,4"  : "iPad mini 2G (WiFi)",
            "iPad4,5"  : "iPad mini 2G (Cellular)",
            "iPad4,7"  : "iPad mini 3 (WiFi)",
            "iPad4,8"  : "iPad mini 3 (Cellular)",
            "iPad4,9"  : "iPad mini 3 (China Model)",
            "iPad5,3"  : "iPad Air 2 (WiFi)",
            "iPad5,4"  : "iPad Air 2 (Cellular)",
            
            "i386"     : "Simulator",
            "x86_64"   : "Simulator"
        ]
    }
    
    public var platform: String {
        var size = UInt()
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = UnsafeMutablePointer<CChar>(malloc(size))
        sysctlbyname("hw.machine", machine, &size, nil, 0)
        let platform = String.fromCString(machine)
        free(machine)
        return platform!
    }
    
    public var platformName: String? {
        return platformNameMapping[platform]
    }
}