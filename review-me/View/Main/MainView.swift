//
//  ContentView.swift
//  review-me
//
//  Created by nabil on 06/01/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    let employeeIndex = 1 // for testing: change this to try other reviewers
    @State var showResult = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.employees.isEmpty {
                    ProgressView("Loading ...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    VStack {
                        Text("Hello: \(viewModel.employees[employeeIndex].name ?? "Unknown")")
                            .font(.title).bold()
                        if showResult {
                            ResultView(employee: viewModel.employees[employeeIndex])
                        } else {
                            Button(action: {
                                showResult = true
                            }) {
                                Text("Reveal Names")
                                    .font(.headline)
                                    .padding()
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }.padding()
                        }
                    }
                }
            }
            .navigationTitle("Review")
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
