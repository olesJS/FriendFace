//
//  User+CoreDataClass.swift
//  FriendFace
//
//  Created by Олексій Якимчук on 02.08.2023.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case id, name, age, company, email, address, about, isActive, registered, friends
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            fatalError("Missing MOC")
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int16.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.registered = try container.decode(Date.self, forKey: .registered)
        self.friends = try container.decode(Set<Friend>.self, forKey: .friends) as NSSet
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(registered, forKey: .registered)
        try container.encode(friends as! Set<Friend>, forKey: .friends)
    }
}

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
