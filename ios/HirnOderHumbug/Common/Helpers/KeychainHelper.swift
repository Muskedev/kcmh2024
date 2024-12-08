//
//  KeychainHelper.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 05.12.24.
//

import KeychainSwift

struct KeychainHelper {
    
    static var shared = KeychainHelper()
    
    private enum Identifier: String {
        case userId = "tt_userid_release"
        case userName = "tt_username_release"
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
    
    var userExist: Bool {
        let id = userId ?? ""
        return !id.isEmpty
    }
    
    func reset() {
        KeychainHelper.shared.userId = nil
        KeychainHelper.shared.userName = nil
    }
}
