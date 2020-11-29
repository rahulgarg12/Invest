//
//  NetworkHandler.swift
//  Invest
//
//  Created by Rahul Garg on 29/11/20.
//

import Foundation

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> ()
typealias ErrorHandler = (HTTPError) -> ()


struct NetworkHandler {
    
    func request<T: Decodable>(urlString: String,
                               method: HTTPMethod,
                               queryParams: NSDictionary? = nil,
                               successHandler: @escaping (T) -> (),
                               errorHandler: @escaping ErrorHandler) {
        
        guard var urlComponents = URLComponents(string: urlString) else {
            return errorHandler(HTTPError.resourceNotFound)
        }
        
        let queryParams: [URLQueryItem]? = queryParams?.compactMap {
            guard let key = $0.key as? String else { return nil }
            return URLQueryItem(name: key, value: "\($0.value)")
        }
        urlComponents.queryItems = queryParams
        
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                return errorHandler(HTTPError.error(error))
            }

            if !self.isSuccessCode(urlResponse) {
                return errorHandler(HTTPError.status)
            }
            
            guard let data = data else {
                return errorHandler(HTTPError.noData)
            }
            
            guard let responseObject = try? JSONDecoder().decode(T.self, from: data) else {
                return errorHandler(HTTPError.decoding)
            }
            
            successHandler(responseObject)
        }
        
        
        guard let url = urlComponents.url else {
            return errorHandler(HTTPError.resourceNotFound)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue(Value.apiTokenKey, forHTTPHeaderField: APIKey.apiTokenHeader)
        URLSession.shared.dataTask(with: request,
                                   completionHandler: completionHandler)
            .resume()
    }
    
    
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }

    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else { return false }
        return isSuccessCode(urlResponse.statusCode)
    }
}
