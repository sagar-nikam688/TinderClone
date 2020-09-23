//
//  NetworkManager.swift
//  Assignment-Tinder
//
//  Created by Admin on 19/09/20.
//  Copyright © 2020 sagar nikam. All rights reserved.
//

import Alamofire

enum APIError: String {
    case networkError
    case apiError
    case decodingError
}

struct NetworkManager {
    
    static var shared: NetworkManager = {
        return NetworkManager()
    }()
    
    let jsonDecoder = JSONDecoder()
    
    // functions to call the APIs
    func getPersons(url: String, completion: @escaping([PersonBO]?, APIError? ) -> ()) {
        guard let url = URL(string: url) else {
            return
        }
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (json) in
            print(json)
            switch json.result {
            case .failure:
                completion(nil, .apiError)
            case .success:
                guard let data = json.data else {
                    completion(nil, .apiError)
                    return
                }
                do {
                    let dataBo = try self.jsonDecoder.decode(PersonDataBO.self, from: data)
                    completion(dataBo.results, nil)
                } catch let error {
                    print(error)
                    completion(nil, .decodingError)
                }
            }
        }
    }
}

