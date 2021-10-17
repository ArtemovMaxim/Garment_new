//
//  AuthAccaunt.swift
//  Garment
//
//  Created by Максим Артемов on 07.10.2021.
//

import Foundation

struct AuthAccaunt {
    enum profile {
        case user
        case store
        case nonAuth
    }
    
    enum status {
        case loged
        case nonLoged
    }
    
    static var authProfile: AuthAccaunt.profile = AuthAccaunt.profile.nonAuth
    static var nameStore: String = ""
    static var statusLog: status = .nonLoged
}
