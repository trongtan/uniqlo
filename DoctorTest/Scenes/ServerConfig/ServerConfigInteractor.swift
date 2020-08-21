//
//  ServerConfigInteractor.swift
//  DoctorTest
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ServerConfigInteractorType {
    func saveServerConfig(serverURL: String, port: String) -> Observable<Void>
}

struct ServerConfigInteractor: ServerConfigInteractorType {
    func saveServerConfig(serverURL: String, port: String) -> Observable<Void> {
        return Observable.create { observable in
            if serverURL.isEmpty || port.isEmpty {
                observable.onError(API.APIError.customError(localizeDescription: "Server URL or Port is empty."))
            }
            
            UserDefaults.standard.setValue(serverURL, forKey: Constants.Key.serverURL)
            UserDefaults.standard.setValue(port, forKey: Constants.Key.serverPort)
            API.shared.baseURL = "\(serverURL):\(port)"
            observable.onNext(())
            
            return Disposables.create()
        }
    }
}
