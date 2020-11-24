//
//  ApiRouter.swift
//  Movies
//
//  Created by Daniel Daverio on 03/11/2020.
//  Copyright © 2020 com.home.Movies. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiRouter: URLRequestConvertible {
    var baseUrl: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
}

extension ApiRouter {
    func asURLRequest() throws -> URLRequest {
        // TODO: Get base url from environment
        let url = baseUrl
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        // Parameters
        switch parameters {
        case let .body(params):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])

        case let .url(params):
            let queryParams = params.map { pair in
                URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        }
        return urlRequest
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case string = "String"
    
}

enum ContentType: String {
    case json = "Application/json"
    case formEncode = "application/x-www-form-urlencoded"
}

enum RequestParams {
    case body(_:Parameters)
    case url(_:Parameters)
}

enum Environment {
    case production
    case qa
    case staging
}
