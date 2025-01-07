//
//  MainViewModel.swift
//  review-me
//
//  Created by nabil on 07/01/2025.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var employees: [Employee] = []
    
    func fetchCSVData() {
        guard let url = URL(string: Constants.dataURL) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let csvString = String(data: data, encoding: .utf8) else {
                print("Failed to decode data")
                return
            }
            
            DispatchQueue.main.async {
                self?.parseCSVAndCreateEmployees(csv: csvString)
            }
        }.resume()
    }

    func parseCSVAndCreateEmployees(csv: String) {
        var employees = [Employee]()
        let lines = csv.split(separator: "\r\n")
        
        guard let header = lines.first else {
            print("Invalid CSV data")
            return
        }
        
        let names = header.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        
        for (rowIndex, line) in lines.enumerated() where rowIndex > 0 {
            let values = line.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            
            guard values.count == names.count else {
                print("Invalid row at index \(rowIndex): \(line)")
                continue
            }
            
            let employeeName = values[0]
            var relationships = [EmployeeRelationship]()
            
            for (colIndex, relationValue) in values.enumerated() where colIndex > 0 {
                let targetName = names[colIndex]
                
                if !Constants.excludedRelationships.contains(relationValue){
                    if let relation = Int(relationValue) {
                        relationships.append(EmployeeRelationship(name: targetName, relation: relation))
                    }
                }
            }
            
            let employee = Employee(name: employeeName, relationships: relationships)
            employees.append(employee)
        }
        
        self.employees = employees
    }
}
