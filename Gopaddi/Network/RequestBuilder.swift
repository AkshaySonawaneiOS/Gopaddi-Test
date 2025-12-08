//
//  RequestBuilder.swift
//  Gopaddi
//
//  Created by Akshay Sonawane on 08/12/25.
//

import Foundation


class RequestBuilder {
    // MARK: - Variables
    static let shared = RequestBuilder()
    typealias JSONDictionary = [String: Any]
    
    private init() {}
    
    // MARK: - GetRequest
    func getRequest(urlString: String,
                    completion: @escaping (Result<JSONDictionary, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //Add Header Here
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.handleResponse(data: data, error: error, completion: completion)
            }
        }.resume()
    }

    // MARK: - Post Request
    func postRequest(urlString: String,
                     parameters: JSONDictionary,
                     completion: @escaping (Result<JSONDictionary, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //Add Header Here
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.handleResponse(data: data, error: error, completion: completion)
            }
        }.resume()
    }

    
    // MARK: - Error Handler
    private func handleResponse( data: Data?, error: Error?, completion: @escaping (Result<JSONDictionary, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? JSONDictionary
            completion(.success(json ?? [:]))
        } catch {
            completion(.failure(error))
        }
    }

    
    
}
