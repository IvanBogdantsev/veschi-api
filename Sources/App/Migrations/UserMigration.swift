//
//  File.swift
//
//
//  Created by Vanya Bogdantsev on 03.06.2024.
//

import Fluent

extension User {
    struct Migration: AsyncMigration {
        func prepare(on database: any Database) async throws {
            return try await database.schema(User.schema)
                .id()
                .field(User.Constants.Fields.username, .string, .required)
                .field(User.Constants.Fields.name, .string)
                .field(User.Constants.Fields.surname, .string)
                .field(User.Constants.Fields.email, .string)
                .field(User.Constants.Fields.password_hash, .string)
                .field(User.Constants.Fields.description, .string, .required)
                .field(User.Constants.Fields.things, .array(of: .string), .required)
                .field(User.Constants.Fields.liked_things, .array(of: .string), .required)
                .field(User.Constants.Fields.going_for, .string)
                .field(User.Constants.Fields.created_at, .datetime, .required)
                .field(User.Constants.Fields.last_activity, .datetime, .required)
                .unique(on: User.Constants.Fields.username)
                .unique(on: User.Constants.Fields.email)
                .create()
        }
        
        func revert(on database: any Database) async throws {
            return try await database.schema(User.schema).delete()
        }
    }
}
