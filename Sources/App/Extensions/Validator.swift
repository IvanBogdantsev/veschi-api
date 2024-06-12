//
//  File.swift
//  
//
//  Created by Vanya Bogdantsev on 04.06.2024.
//

import Vapor

public enum PasswordError: String, Sendable {
    case password_too_short
    case no_special_character
    case no_uppercase_letter
    case no_lowercase_letter
    case no_digit
}

extension ValidatorResults {
    public struct Password {
        public let isValidPassword: Bool
        public var reason: PasswordError?
    }
}

extension ValidatorResults.Password: ValidatorResult {
    public var isFailure: Bool {
        return !isValidPassword
    }
    
    public var successDescription: String? {
        return nil
    }
    
    public var failureDescription: String? {
        return reason?.rawValue
    }
}

extension Validator where T == String {
    public static var password: Validator<T> {
        return .init {
            guard $0.count >= 8 else {
                return ValidatorResults.Password(isValidPassword: false, reason: .password_too_short)
            }
            let specialCharacterRegex = ".*[^A-Za-z0-9].*"
            let uppercaseLetterRegex = ".*[A-Z].*"
            let lowercaseLetterRegex = ".*[a-z].*"
            let digitRegex = ".*[0-9].*"
            
            let specialCharacterTest = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
            let uppercaseLetterTest = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex)
            let lowercaseLetterTest = NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegex)
            let digitTest = NSPredicate(format: "SELF MATCHES %@", digitRegex)
            
            guard specialCharacterTest.evaluate(with: $0) else {
                return ValidatorResults.Password(isValidPassword: false, reason: .no_special_character)
            }
            guard uppercaseLetterTest.evaluate(with: $0) else {
                return ValidatorResults.Password(isValidPassword: false, reason: .no_uppercase_letter)
            }
            guard lowercaseLetterTest.evaluate(with: $0) else {
                return ValidatorResults.Password(isValidPassword: false, reason: .no_lowercase_letter)
            }
            guard digitTest.evaluate(with: $0) else {
                return ValidatorResults.Password(isValidPassword: false, reason: .no_digit)
            }
            return ValidatorResults.Password(isValidPassword: true)
        }
    }
}
