//
//  Employee.swift
//  review-me
//
//  Created by nabil on 07/01/2025.
//

import Foundation

class Employee: Identifiable, Hashable {
    var id = UUID()
    var name: String?
    var relationships: [EmployeeRelationship]

    init(name: String? = nil, relationships: [EmployeeRelationship] = []) {
        self.name = name
        self.relationships = relationships
    }

    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
