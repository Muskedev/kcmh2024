//
//  NetworkError.swift
//  HirnOderHumbug
//
//  Created by Mia Koring on 02.12.24.
//
import Foundation

enum NetworkError: Error {
    case invalidUrl
    case jsonEncoding
    case responseDecode
}
