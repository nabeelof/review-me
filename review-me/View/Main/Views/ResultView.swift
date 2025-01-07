//
//  ResultView.swift
//  review-me
//
//  Created by nabil on 07/01/2025.
//

import SwiftUI

struct ResultView: View {
    var employee: Employee
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(employee.relationships.isEmpty ? "You have no one to review !!" : "Could you review:")
                .font(.subheadline)
            ForEach(employee.relationships) { relationship in
                Text("\(relationship.name ?? "Unknown")")
                    .font(.body)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    ResultView(employee: Employee(name: "Nabil", relationships: [EmployeeRelationship(name: "Ahmad", relation: 3)]))
}
