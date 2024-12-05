//
//  BHAPIError.swift
//  HirnOderHumbug
//
//  Created by Mia Koring on 02.12.24.
//

import Foundation

enum BHAPIError: Error, Equatable {
    case notFound
    case unauthorized
    case unknown(String)
}

extension BHAPIError: LocalizedError {
    static func byReason(_ reason: String) -> BHAPIError {
        .unknown(reason)
    }
    
    var errorDescription: String? {
        ""
    }
}

extension BHAPIError: Identifiable {
    var id: String {
        "\(self.localizedDescription)"
    }
}
