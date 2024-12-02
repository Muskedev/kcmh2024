//
//  URLReqEndpoint.swift
//  HirnOderHumbug
//
//  Created by Mia Koring on 02.12.24.
//
import Mammut

protocol URLReqEndpoint: Endpoint {
    var urlReqHeaders: [String: String] { get }
}
