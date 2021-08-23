//
//  APIService.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import UIKit
import Alamofire

final class APIService {
    private init() {}
    static let shared = APIService()
    
    let BASE_URL = "http://www.omdbapi.com"
    let API_KEY = "c11a3f3a"
    let API_PAGE_LIMIT = 10
    
    var isReachable: Bool {
        get {
            return NetworkReachabilityManager()?.isReachable ?? false
        }
    }
    
    func request<T: Decodable>(
        endpoint: Endpoint,
        page: Int? = nil,
        completion: @escaping (Result<T?, ErrorModel>) -> Void
    ) {
        var parameters = endpoint.parameters
        
        if let page = page {
            if parameters == nil {
                parameters = Parameters()
            }
            
            parameters?["page"] = page
        }
        
        print("\(endpoint.httpMethod.rawValue) REQUEST\nurl: \(endpoint.urlString)\nparameters: \(parameters ?? Parameters())\n")
        
        let dataRequest = AF.request(
            endpoint.urlString,
            method: endpoint.httpMethod,
            parameters: parameters,
            headers: endpoint.headers
        )
        
        dataRequest.response { (result) in
            if let error = result.error {
                completion(.failure(.init(
                    title: "Internal Error",
                    message: error.localizedDescription
                )))
                
                return
            }
            
            guard let response = result.response else {
                completion(.failure(.init(
                    title: "Nil Response",
                    message: "An error has occurred."
                )))
                
                return
            }
            
            if (200 ..< 300) ~= response.statusCode { // success
                if let data = result.data {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        
                        completion(.success(decodedData))
                    } catch {
                        print(error)
                        
                        do {
                            let decodedData = try JSONDecoder().decode(ErrorModel.self, from: data)

                            completion(.failure(decodedData))
                        } catch {
                            print(error)

                            completion(.failure(.init(
                                title: "\(ErrorModel.self) Decode Error",
                                message: error.localizedDescription
                            )))
                        }

//                        completion(.failure(.init(
//                            title: "\(T.self) Decode Error",
//                            message: error.localizedDescription
//                        )))
                    }
                } else {
                    completion(.success(nil))
                }
            } else { // failure
                if let data = result.data {
                    do {
                        let decodedData = try JSONDecoder().decode(ErrorModel.self, from: data)
                        
                        completion(.failure(decodedData))
                    } catch {
                        print(error)
                        
                        completion(.failure(.init(
                            title: "\(ErrorModel.self) Decode Error",
                            message: error.localizedDescription
                        )))
                    }
                } else {
                    completion(.failure(.init(
                        title: "Nil Error",
                        message: "An error has occurred."
                    )))
                }
            }
        }
    }
}
