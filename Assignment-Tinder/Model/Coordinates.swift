//
//  CoordinatesBO.swift
//  Assignment-Tinder
//
//  Created by Admin on 19/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import Foundation
struct CoordinatesBO: Codable {
	let latitude: String?
	let longitude: String?

	enum CodingKeys: String, CodingKey {
		case latitude
		case longitude
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
	}

}
