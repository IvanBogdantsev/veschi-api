//
//  File.swift
//  
//
//  Created by Vanya Bogdantsev on 10.06.2024.
//

import Vapor

struct UserValidatorMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        try User.Create.validate(content: request)
        return try await next.respond(to: request)
    }
}
