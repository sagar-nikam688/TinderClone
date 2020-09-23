//
//  LoginBO.swift
//  Assignment-Tinder
//
//  Created by Admin on 19/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import Foundation
struct LoginBO: Codable {
	let uuid: String?
	let username: String?
	let password: String?
	let salt: String?
	let md5: String?
	let sha1: String?
	let sha256: String?

	enum CodingKeys: String, CodingKey {
		case uuid
		case username
		case password
		case salt
		case md5
		case sha1
		case sha256
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
		username = try values.decodeIfPresent(String.self, forKey: .username)
		password = try values.decodeIfPresent(String.self, forKey: .password)
		salt = try values.decodeIfPresent(String.self, forKey: .salt)
		md5 = try values.decodeIfPresent(String.self, forKey: .md5)
		sha1 = try values.decodeIfPresent(String.self, forKey: .sha1)
		sha256 = try values.decodeIfPresent(String.self, forKey: .sha256)
	}

}
