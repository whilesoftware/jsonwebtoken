//
//  String.swift
//  jsonwebtoken
//
//  Created by Alan McCosh on 7/29/20.
//

import Foundation

extension String {
    var base64FromBase64Url: String {
        var base64 = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        base64 += String(repeating: "=", count: base64.count % 4)
        
        return base64
    }
}
