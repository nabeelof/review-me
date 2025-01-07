//
//  ContentView.swift
//  review-me
//
//  Created by nabil on 06/01/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var selectedEmployee: Employee?

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.employees.isEmpty {
                    ProgressView("Loading ...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    Picker("Select Employee", selection: $selectedEmployee) {
                        Text("Please Select").tag(nil as Employee?)
                        ForEach(viewModel.employees) { employee in
                            Text(employee.name ?? "Unknown").tag(employee as Employee?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()

                    if let employee = selectedEmployee {
                        ResultView(employee: employee)
                    } else {
                        Text("Select an employee to view reviewees.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
            }
            .navigationTitle("Review Me")
            .onAppear {
                viewModel.fetchCSVData()
            }
            .padding()
        }
    }
}


#Preview {
    MainView()
}
