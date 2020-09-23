//
//  RegisteredBO.swift
//  Assignment-Tinder
//
//  Created by Admin on 19/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import Foundation
struct RegisteredBO: Codable {
	let date: String?
	let age: Int?

	enum CodingKeys: String, CodingKey {
		case date
		case age
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		age = try values.decodeIfPresent(Int.self, forKey: .age)
	}

}
