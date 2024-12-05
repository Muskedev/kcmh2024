//
//  ErrorResponse.swift
//  HirnOderHumbug
//
//  Created by Mia Koring on 02.12.24.
//

struct ErrorResponse: Codable {
    let detail: [ValidationError]
}

struct ValidationError: Codable {
    let msg: String
    let type: String
}
