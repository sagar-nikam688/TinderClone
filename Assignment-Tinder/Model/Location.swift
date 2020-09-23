//
//  LocationBO.swift
//  Assignment-Tinder
//
//  Created by Admin on 19/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import Foundation
struct LocationBO: Codable {
	let street: StreetBO?
	let city: String?
	let state: String?
	let country: String?
	let postcode: Int?
	let coordinates: CoordinatesBO?
	let timezone: TimezoneBO?

	enum CodingKeys: String, CodingKey {
		case street
		case city
		case state
		case country
		case postcode
		case coordinates
		case timezone
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		street = try values.decodeIfPresent(StreetBO.self, forKey: .street)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		state = try values.decodeIfPresent(String.self, forKey: .state)
		country = try values.decodeIfPresent(String.self, forKey: .country)
        do {
            postcode = try values.decode(Int.self, forKey: .postcode)
        } catch DecodingError.typeMismatch {
            postcode = try Int(values.decode(String.self, forKey: .postcode))
        }

//		postcode = try values.decodeIfPresent(Int.self, forKey: .postcode)
		coordinates = try values.decodeIfPresent(CoordinatesBO.self, forKey: .coordinates)
		timezone = try values.decodeIfPresent(TimezoneBO.self, forKey: .timezone)
	}

}
