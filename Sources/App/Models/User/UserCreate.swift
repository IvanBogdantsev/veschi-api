//
//  File.swift
//  
//
//  Created by Vanya Bogdantsev on 03.06.2024.
//

import Vapor

extension User {
    struct Create: Content {
        var username: String
        var email: String
        var password: String
    }
}

extension User.Create: Validatable {
    enum Fields {
        static let username: ValidationKey = "username"
        static let email: ValidationKey = "email"
        static let password: ValidationKey = "password"
    }
    // MARK: Наверное это нужно убрать и сделать свои валидаторы
    static func validations(_ validations: inout Validations) {
        validations.add(Fields.username, as: String.self, is: !.empty)
        validations.add(Fields.email, as: String.self, is: .email)
        validations.add(Fields.password, as: String.self, is: .password)
    }
}

