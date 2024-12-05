//
//  NetworkEnv.swift
//  HirnOderHumbug
//
//  Created by Mia Koring on 02.12.24.
//

import Foundation

enum NetworkEnv {
    case brainOrHumbug
}

extension NetworkEnv {
    var scheme: String {
        switch self {
        case .brainOrHumbug: "https"
        }
    }

    var host: String {
        switch self {
        case .brainOrHumbug: ""
        }
    }

    var path: String {
        ""
    }

    var components: URLComponents {
        var comp = URLComponents()
        comp.scheme = scheme
        comp.host = host
        comp.path = path
        return comp
    }
}
