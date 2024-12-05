//
//  KeychainHelper.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 05.12.24.
//

import KeychainSwift

struct KeychainHelper {
    
    static let shared = KeychainHelper()
    
    private enum Identifier: String {
        case userId = "tt_userid"
        case userName = "tt_username"
    }
    
    let keychain = KeychainSwift()
    
    var userId: String? {
        get { keychain.get(Identifier.userId.rawValue) }
        set { keychain.set(newValue ?? "", forKey: Identifier.userId.rawValue) }
    }
    
    var userName: String? {
        get { keychain.get(Identifier.userName.rawValue) }
        set { keychain.set(newValue ?? "", forKey: Identifier.userName.rawValue) }
    }
}
