//
//  BHAPI.swift
//  HirnOderHumbug
//
//  Created by Mia Koring on 02.12.24.
//
import Foundation
import Mammut

enum BHAPI {
    case test
}
extension BHAPI: URLReqEndpoint {
    var path: String {
       ""
    }

    var method: MammutMethod {
        .get
    }

    var headers: [MammutHeader] {
        []
    }
    
    var urlReqHeaders: [String: String] {
        [:]
    }

    var parameters: [String : Any] {
        [:]
    }

    var encoding: Encoding {
        .json
    }
}
