//
//  NetworkService.swift
//  Network
//
//  Created by Vitaliy Ampilogov on 6/8/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import Utils

public protocol INetworkService {
    
    // Send request and get parsed result
    @discardableResult
    func load<T: NetworkRequest>(_ request: T, completion: @escaping (Result<T.Model, Error>) -> Void)  -> Cancelable
}

public class NetworkService: INetworkService {
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func load<T: NetworkRequest>(_ request: T, completion: @escaping (Result<T.Model, Error>) -> Void) -> Cancelable {
        let urlRequest = request.constructURLRequest()
        
        let task = session.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { completion(Result.failure(NSError.network)); return }
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.Model.self, from: data)
                completion(.success(model))
            } catch let error {
                completion(.failure(error)); return
            }
        }
        
        task.resume()
        return task
    }
}
