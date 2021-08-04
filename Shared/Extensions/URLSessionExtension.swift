//
//  URLSessionExtension.swift
//  LicenseUnborker
//
//  Created by Andrew Pirkl on 3/13/20.
//  Copyright © 2020 Pirklator. All rights reserved.
//

import Foundation
import os.log

extension URLSession {
    /**
     Run a dataTask escaping a result optionally adding a token provider for just in time authentication
     */
    func dataTask(request: URLRequest, result: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: request) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                result(.failure(DataTaskError.emptyData))
                return
            }
            guard let urlResponse = response as? HTTPURLResponse else {
                result(.failure(DataTaskError.unknown))
                return
            }
            let statusCode = urlResponse.statusCode
            if statusCode < 200 || statusCode > 299 {
                result(.failure(DataTaskError.requestFailure(description: HTTPURLResponse.localizedString(forStatusCode: statusCode), statusCode: statusCode)))
                return
            }
            result(.success(data))
        }
    }
}
