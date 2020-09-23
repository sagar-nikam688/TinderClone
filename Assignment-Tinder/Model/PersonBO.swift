//
//  PersonBO.swift
//  Assignment-Tinder
//
//  Created by Admin on 19/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import Foundation

struct PersonBO: Codable {
    var gender: String?
    var name: NameBO?
    var location: LocationBO?
    var email: String?
    var login: LoginBO?
    var dob: DobBO?
    var registered: RegisteredBO?
    var phone: String?
    var cell: String?
    var id: IdBO?
    var picture: PictureBO?
    var nat: String?

    enum CodingKeys: String, CodingKey {
        case gender
        case name
        case location
        case email
        case login
        case dob
        case registered
        case phone
        case cell
        case id
        case picture
        case nat
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        name = try values.decodeIfPresent(NameBO.self, forKey: .name)
        location = try values.decodeIfPresent(LocationBO.self, forKey: .location)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        login = try values.decodeIfPresent(LoginBO.self, forKey: .login)
        dob = try values.decodeIfPresent(DobBO.self, forKey: .dob)
        registered = try values.decodeIfPresent(RegisteredBO.self, forKey: .registered)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        cell = try values.decodeIfPresent(String.self, forKey: .cell)
        id = try values.decodeIfPresent(IdBO.self, forKey: .id)
        picture = try values.decodeIfPresent(PictureBO.self, forKey: .picture)
        nat = try values.decodeIfPresent(String.self, forKey: .nat)
    }
}
