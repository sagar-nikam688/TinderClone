//
//  StreetBO.swift
//  Assignment-Tinder
//
//  Created by Admin on 19/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import Foundation
struct StreetBO: Codable {
	let number: Int?
	let name: String?

	enum CodingKeys: String, CodingKey {
		case number
		case name
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		number = try values.decodeIfPresent(Int.self, forKey: .number)
		name = try values.decodeIfPresent(String.self, forKey: .name)
	}

}
