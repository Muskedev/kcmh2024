//
//  AboutMember.swift
//  HirnOderHumbug
//
//  Created by Simon Zwicker on 05.12.24.
//

enum AboutMember: String, CaseIterable {
    case simon
    case kirreth
    case sephi
    case amelie
    case nico
    case mia
}

extension AboutMember {
    var name: String {
        switch self {
        case .simon: "Simon Sr."
        case .kirreth: "Kirreth"
        case .sephi: "Sephirot"
        case .amelie: "Amelie"
        case .nico: "CSwNico"
        case .mia: "MiaCodes"
        }
    }
    
    var function: String {
        switch self {
        case .simon: "iOS Entwicklung, Design & Organisation"
        case .kirreth: "Organisation, Design & Backend"
        case .sephi: "Backend & KI"
        case .amelie: "Design, Ideen & kreative Arbeiten"
        case .nico: "iOS Entwicklung & Design"
        case .mia: "iOS Entwicklung, Anbindung der Schnittstelle"
        }
    }
}
