//
//  NameBO.swift
//  Assignment-Tinder
//
//  Created by Admin on 19/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import Foundation
struct NameBO: Codable {
	let title: String?
	let first: String?
	let last: String?

	enum CodingKeys: String, CodingKey {
		case title
		case first
		case last
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		first = try values.decodeIfPresent(String.self, forKey: .first)
		last = try values.decodeIfPresent(String.self, forKey: .last)
	}

}
