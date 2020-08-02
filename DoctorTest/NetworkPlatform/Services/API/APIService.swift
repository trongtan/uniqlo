//
//  APIService.swift
//  DemoCleanArchitecture-IOS
//
//  Created by TanVu on 4/1/19.
//  Copyright © 2019 TanVu. All rights reserved.
//

import ObjectMapper
import Alamofire
import RxSwift
import RxAlamofire

func == <K, V>(left: [K: V], right: [K: V]) -> Bool {
    return NSDictionary(dictionary: left).isEqual(to: right)
}

typealias JSONDictionary = [String: Any]

final class API {
    static let shared = API()
    var baseURL: String
    
    init(baseURL: ServerURL = .dev) {
        guard let url = UserDefaults.standard.value(forKey: Constants.Key.serverURL) as? String,
            let port = UserDefaults.standard.value(forKey: Constants.Key.serverPort) as? String else {
                self.baseURL = baseURL.rawValue
                return
        }
        
        self.baseURL = "\(url):\(port)"
    }
    
    func request<T: Mappable>(_ input: APIInputBase) -> Observable<T> {
        return request(input)
            .map { json -> T in
                if let t = T(JSON: json) {
                    return t
                }
                throw APIError.invalidResponseData
        }
    }
    
}

// MARK: - Support methods
extension API {
    fileprivate func request(_ input: APIInputBase) -> Observable<JSONDictionary> {
        let urlRequest = preprocess(input)
            .do(onNext: { input in
                print(input)
            })
            .flatMapLatest { input in
                Alamofire
                    .SessionManager
                    .default
                    .rx
                    .request(input.requestType,
                             self.baseURL+input.urlString,
                             parameters: input.parameters,
                             encoding: input.encoding,
                             headers: input.headers)
        }
        .do(onNext: { (_) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        })
            .flatMapLatest { dataRequest -> Observable<(HTTPURLResponse, Data)> in
                return dataRequest
                    .rx.responseData()
        }
        .do(onNext: { (_) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }, onError: { (_) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        })
            .map { (dataResponse) -> JSONDictionary in
                return try self.process(dataResponse)
        }
        .catchError({ [weak self] error -> Observable<[String : Any]> in
            guard let this = self else { return Observable.empty() }
            if case API.APIError.expiredToken = error {
                // MARK: Add call refresh token
                return this.request(input)
            }
            throw error
        })
        
        return urlRequest
    }
    
    fileprivate func process(_ response: (HTTPURLResponse, Data)) throws -> JSONDictionary {
        let (response, data) = response
        let json: JSONDictionary? = (try? JSONSerialization.jsonObject(with: data, options: [])) as? JSONDictionary
        let error: Error
        switch response.statusCode {
        case 200..<300:
            print("👍 [\(response.statusCode)] " + (response.url?.absoluteString ?? ""))
            return json ?? JSONDictionary()
            //        case 401:
        //            error = APIError.expiredToken
        default:
            if let json = json, let responseError = ResponseError(JSON: json) {
                error = APIError.error(response: responseError)
            } else {
                error = APIError.unknown(statusCode: response.statusCode)
            }
            print("❌ [\(response.statusCode)] " + (response.url?.absoluteString ?? ""))
            if let json = json {
                print(json)
            }
        }
        throw error
    }
    
    fileprivate func preprocess(_ input: APIInputBase) -> Observable<APIInputBase> {
        return Observable.deferred {
            if input.requireAccessToken {
                // MARK: get token
                
                let token = UserDefaults.standard.value(forKey: Constants.Key.token) as! String
                var headers = input.headers
                headers["Authorization"] = "Bearer \(token)"
                input.headers = headers
                input.accessToken = token
                return Observable.just(input)
            } else {
                return Observable.just(input)
            }
        }
    }
}
