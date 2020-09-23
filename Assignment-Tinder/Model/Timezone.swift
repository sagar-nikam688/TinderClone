//
//  TimezoneBO.swift
//  Assignment-Tinder
//
//  Created by Admin on 19/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import Foundation
struct TimezoneBO: Codable {
	let offset: String?
	let description: String?

	enum CodingKeys: String, CodingKey {
		case offset
		case description
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		offset = try values.decodeIfPresent(String.self, forKey: .offset)
		description = try values.decodeIfPresent(String.self, forKey: .description)
	}

}
