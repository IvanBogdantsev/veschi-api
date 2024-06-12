//
//  User.swift
//
//
//  Created by Vanya Bogdantsev on 02.06.2024.
//

import Fluent
import Vapor

final class User: Model, Content {
    
    enum Constants {
        static let schema = "users"
        
        enum Fields {
            static let username: FieldKey = "username"
            static let name: FieldKey = "name"
            static let surname: FieldKey = "surname"
            static let email: FieldKey = "email"
            static let password_hash: FieldKey = "password_hash"
            static let description: FieldKey = "description"
            static let things: FieldKey = "things"
            static let liked_things: FieldKey = "liked_things"
            static let going_for: FieldKey = "going_for"
            static let created_at: FieldKey = "created_at"
            static let last_activity: FieldKey = "last_activity"
        }
    }
    
    static let schema = Constants.schema
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: Constants.Fields.username)
    var username: String
    
    @OptionalField(key: Constants.Fields.name)
    var name: String?
    
    @OptionalField(key: Constants.Fields.surname)
    var surname: String?
    
    @OptionalField(key: Constants.Fields.email)
    var email: String?
    
    @Field(key: Constants.Fields.password_hash)
    var password_hash: String
    
    @OptionalField(key: Constants.Fields.description)
    var description: String?
    
    @Field(key: Constants.Fields.things)
    var things: [String]
    
    @Field(key: Constants.Fields.liked_things)
    var liked_things: [String]
    
    @OptionalField(key: Constants.Fields.going_for)
    var going_for: String?
    
    @Field(key: Constants.Fields.created_at)
    var created_at: Date
    
    @Field(key: Constants.Fields.last_activity)
    var last_activity: Date
    
    init() {}
    
    init(id: UUID? = nil, username: String, name: String?, surname: String?, email: String, password_hash: String, description: String?, things: [String], likedThings: [String], goingFor: String? = nil, created_at: Date, lastActivity: Date) {
        self.id = id
        self.username = username
        self.name = name
        self.surname = surname
        self.email = email
        self.password_hash = password_hash
        self.description = description
        self.things = things
        self.liked_things = likedThings
        self.going_for = goingFor
        self.created_at = created_at
        self.last_activity = lastActivity
    }
    
}

