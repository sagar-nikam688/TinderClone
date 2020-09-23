//
//  PictureBO.swift
//  Assignment-Tinder
//
//  Created by Admin on 19/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import Foundation
struct PictureBO : Codable {
	let large : String?
	let medium : String?
	let thumbnail : String?

	enum CodingKeys: String, CodingKey {
		case large
		case medium
		case thumbnail
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		large = try values.decodeIfPresent(String.self, forKey: .large)
		medium = try values.decodeIfPresent(String.self, forKey: .medium)
		thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
	}

}
