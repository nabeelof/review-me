//
//  EmployeeRelationship.swift
//  review-me
//
//  Created by nabil on 07/01/2025.
//

import Foundation

class EmployeeRelationship: Identifiable, Hashable {
    var id = UUID()
    var name: String?
    var relation: Int?

    init(name: String? = nil, relation: Int? = nil) {
        self.name = name
        self.relation = relation
    }

    static func == (lhs: EmployeeRelationship, rhs: EmployeeRelationship) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
