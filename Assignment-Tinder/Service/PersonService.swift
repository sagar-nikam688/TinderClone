//
//  PersonService.swift
//  Assignment-Tinder
//
//  Created by Admin on 19/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import Foundation


class PersonService: NSObject {
    func getPeopels(query: String, completion: @escaping ([PersonBO]?, APIError?) -> Void) {
        let endPoint =  "https://randomuser.me/api/?results=\(query)"
        NetworkManager.shared.getPersons(url: endPoint) { (peoples, error) in
            if error != nil {
                completion(nil, error)
                print(error.debugDescription)
            } else {
                completion(peoples, nil)
            }
        }
    }
}
