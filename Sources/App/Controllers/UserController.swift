//
//  UserController.swift
//
//
//  Created by Vanya Bogdantsev on 05.06.2024.
//

import Fluent
import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let usersRoute = routes.grouped(RoutesList.Users.root)
        // MARK: COERCE AT AUTH
        let createUserRouteMiddlewared = usersRoute.grouped(UserFormattingMiddleware(),
                                                            UserValidatorMiddleware())
        
        createUserRouteMiddlewared.post(use: createHandler)
        usersRoute.get(use: getAllHandler)
        usersRoute.get(RoutesList.Users.checkUsername, use: checkUsernameHandler)
    }
    
    @Sendable
    func createHandler(_ req: Request) async throws -> User {        
        let create = try req.content.decode(User.Create.self)
        let passwordHash = try Bcrypt.hash(create.password)
        let user = User(username: create.username,
                        name: nil,
                        surname: nil,
                        email: create.email,
                        password_hash: passwordHash,
                        description: nil,
                        things: [],
                        likedThings: [],
                        goingFor: nil,
                        created_at: Date.now,
                        lastActivity: Date.now)
        try await user.save(on: req.db)
        return user
    }
    
    @Sendable
    func getAllHandler(_ req: Request) async throws -> [User] {
        return try await User.query(on: req.db).all()
    }
    
    @Sendable
    func checkUsernameHandler(_ req: Request) async throws -> UsernameStatus {
        guard let username = req.query[String.self, at: User.Create.Fields.username.stringValue] else {
            throw Abort(.badRequest)
        }
        
        
        
        if try await User.query(on: req.db).filter(\.$username == username.lowercased()).first() != nil {
            return .taken
        } else {
            return .available
        }
    }
}
