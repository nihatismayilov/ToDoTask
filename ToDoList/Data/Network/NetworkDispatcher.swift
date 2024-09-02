//
//  NetworkDispatcher.swift
//  ToDoList
//
//  Created by Nihad Ismayilov on 31.08.24.
//

import Foundation
import Combine

protocol Dispatcher {
    func execute<Response: Decodable>(for request: Request) -> AnyPublisher<Response, Error>
}

class BypassingURLSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}

class NetworkDispatcher: Dispatcher {
    private var cancellables: Set<AnyCancellable> = []
    private var session: URLSession
    
    public required init() {
        let configuration = URLSessionConfiguration.default
        configuration.tlsMinimumSupportedProtocolVersion = .TLSv12
        let delegate = BypassingURLSessionDelegate()
        self.session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
    }
    
    public func execute<Response: Decodable>(for request: Request) -> AnyPublisher<Response, Error> {
                
        return Future<Response, Error> { [weak self] promise in
            guard let self else {
                promise(.failure(NetworkErrors.unknownError(0)))
                return
            }
            
            if !ConnectionChecker.isConnectedToNetwork() {
                promise(.failure(NetworkErrors.connection))
                return
            }
            
            do {
                let urlRequest = try self.urlRequest(for: request)
                self.performRequest(urlRequest, promise: promise)
            } catch {
                promise(.failure(error))
            }
            
        }.eraseToAnyPublisher()
    }

    private func performRequest<Response: Decodable>(_ urlRequest: URLRequest, promise: @escaping (Result<Response, Error>) -> Void) {
        
        print("\nURLREQUEST: \((urlRequest.url?.absoluteString).orEmpty) \(urlRequest.httpMethod.orEmpty)\n")
        
        session.dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) -> Data in
                if let httpURLResponse = response as? HTTPURLResponse {
                    try self.validate(httpURLResponse)
                }
                print("DATA: \n", data.prettyPrintedJSONString ?? "")
                return data
            }
            .decode(type: Response.self, decoder: JSON.decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    promise(.failure(error))
                }
            }, receiveValue: { response in
                promise(.success(response))
            })
            .store(in: &cancellables)
    }

    private func validate(_ response: HTTPURLResponse) throws {
        print("RESPONSE CODE: \(response.statusCode)")
        switch response.statusCode {
        case 200...299: return
        case 401: throw NetworkErrors.unauthorized
        default: throw NetworkErrors.unknownError(response.statusCode)
        }
    }
    
    private func urlRequest(for request: Request) throws -> URLRequest {

        var fullURL = "\(request.baseUrl.rawValue)\(request.endpoint)"
        var urlRequest = URLRequest(url: URL(string: fullURL)!)
        switch request.parameters {
        case .body(let params):
            if let params = params {
                if !params.isEmpty {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
                    print("REQUEST BODY: \(try JSONSerialization.data(withJSONObject: params, options: []).prettyPrintedJSONString ?? "NONE")\n")
                }
            } else {
                throw NetworkErrors.badInput
            }
        case .url(let params, let isQuery):
            if let params = params as? [String: String] {
                if isQuery {
                    let queryParams = params.map({ (element) -> URLQueryItem in
                        return URLQueryItem(name: element.key, value: element.value)
                    })
                    guard var components = URLComponents(string: fullURL) else {
                        throw NetworkErrors.badInput
                    }
                    components.queryItems = queryParams
                    urlRequest.url = components.url
                } else {
                    let queryString = params.map({ $0.value }).joined(separator: "/")
                    fullURL += queryString
                    urlRequest = URLRequest(url: URL(string: fullURL)!)
                }
            } else {
                throw NetworkErrors.badInput
            }
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.headers?.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        urlRequest.httpMethod = request.method.rawValue
        
        urlRequest.timeoutInterval = 120
        
        print("HEADERS: \n", urlRequest.allHTTPHeaderFields ?? [:])
     
        return urlRequest
    }
}
