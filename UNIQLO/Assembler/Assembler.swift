//
//  Assembler.swift
//  DemoCleanArchitecture-IOS
//
//  Created by TanVu on 4/1/19.
//  Copyright © 2019 TanVu. All rights reserved.
//

protocol Assembler: class,
    LoginAssembler,
    BarcodeReaderAssembler,
    InformationAssembler,
    FinishAssembler,
    ServerConfigAssembler,
    VerifyAssembler
{
}

class DefaultAssembler: Assembler {
    static let shared = DefaultAssembler()
}

protocol NavigatorType {
    
}

protocol InteractorType {
    
}
