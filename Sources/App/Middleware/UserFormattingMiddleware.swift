//
//  File.swift
//  
//
//  Created by Vanya Bogdantsev on 11.06.2024.
//

import Vapor

struct UserFormattingMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        if var createUser = try? request.content.decode(User.Create.self) {
            createUser.email = createUser.email.lowercased()
            createUser.username = createUser.username.lowercased()
            try request.content.encode(createUser)
            
        }
        return try await next.respond(to: request)
    }
}
