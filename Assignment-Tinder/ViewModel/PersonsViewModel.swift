//
//  PersonsViewModel.swift
//  Assignment-Tinder
//
//  Created by Admin on 22/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import Foundation
import Combine
class PersonsViewModel: ObservableObject {
    var errorMessage: String?
    var error: Bool = false

    @Published var peoples: [PersonBO] = []
    var personsRepository: PersonsRepository?

    init(repository: PersonsRepository = PersonsRepository()) {
        self.personsRepository = repository
    }

    func setEmployeeRepository(repository: PersonsRepository) {
        self.personsRepository = repository
    }

    func fetchPersons(queryParams: String) {
        self.personsRepository?.getPersons(queryParams: queryParams) { peoples, error in
            if error != nil {
                self.setError(error?.rawValue ?? "networkError")
            } else {
                self.peoples = peoples ?? []
                print(self.$peoples)
            }
        }
    }

    func setError(_ message: String) {
        self.errorMessage = message
        self.error = true
    }

}
