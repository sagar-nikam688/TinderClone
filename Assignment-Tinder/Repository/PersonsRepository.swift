//
//  PersonsRepository.swift
//  Assignment-Tinder
//
//  Created by Admin on 22/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import Foundation
protocol PersonsRepositoryProtocol {
    func getPersons(queryParams: String, completion:@escaping ([PersonBO]?, APIError?) -> Void)
}
public class PersonsRepository: NSObject {
    var personService = PersonService()
}

extension PersonsRepository: PersonsRepositoryProtocol {
    func getPersons(queryParams: String, completion: @escaping ([PersonBO]?, APIError?) -> Void) {
        self.personService.getPeopels(query: queryParams, completion: { (peoples, error) in
            completion(peoples, error)
        })
    }
}
