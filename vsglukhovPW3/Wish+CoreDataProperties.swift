//
//  Wish+CoreDataProperties.swift
//  vsglukhovPW3
//
//  Created by Valentin Glukhov on 17.03.2024.
//
//

import Foundation
import CoreData

@objc(Wish)
public class Wish: NSManagedObject { }


extension Wish {
    @NSManaged public var wish: String?
    @NSManaged public var id: Int32
}

extension Wish : Identifiable {}
