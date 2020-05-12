//
//  EmployeesView.swift
//  RWReview
//
//  Created by Svyat Zubyak on 12.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import SwiftUI

struct EmployeesView: View {
    
    @ObservedObject var employeesViewModel: EmployeesViewModel = EmployeesViewModel()
    
    @State private var selectedEmployee: EmployeeViewModel?
    @State private var shouldPresentAddEmployeeSheet: Bool = false
    
    let emptyDataViewFactory: EmptyDataViewFactory = EmptyDataViewFactory()
    
    var body: some View {
            
            List {
                
                if !employeesViewModel.activeEmployees.isEmpty {
                    
                    Section(header: EmployeesSectionHeader(text: "Active")) {
                        
                        ForEach(employeesViewModel.activeEmployees) { employee in
                            
                            NavigationLink(destination: EmployeeDetailsView(employee: employee)) {
                                
                                EmployeesListRow(name: employee.fullName, role: employee.role?.uppercasedName, profilePictureURL: employee.profilePictureURL, isActive: employee.isActive)
                            }
                        }
                    }
                }
                
                if !employeesViewModel.inactiveEmployees.isEmpty {
                    
                    Section(header: EmployeesSectionHeader(text: "Inactive")) {
                        
                        ForEach(employeesViewModel.inactiveEmployees) { employee in
                            
                            NavigationLink(destination: EmployeeDetailsView(employee: employee)) {
                                
                                EmployeesListRow(name: employee.fullName, role: employee.role?.uppercasedName, profilePictureURL: employee.profilePictureURL, isActive: employee.isActive)
                            }
                        }
                    }
                }
            }
            .introspectTableView { tableView in
                tableView.tableFooterView = UIView()
                tableView.separatorStyle = .none
            }
            .emptyDataView(condition: employeesViewModel.activeEmployees.isEmpty && employeesViewModel.inactiveEmployees.isEmpty) {
                self.emptyDataViewFactory.make(.employees)
            }
            .pullToRefresh(isShowing: $employeesViewModel.isLoading) {
                self.employeesViewModel.fetchEmployees()
            }
        
        .sheet(isPresented: $shouldPresentAddEmployeeSheet) {
            NavigationView {
                AddEmployeeView(delegate: self.employeesViewModel as AddEmployeeDelegate)
            }
            .navigationBarWithShadow()
        }
                
        .navigationBarTitle(Text("Employees"), displayMode: .inline)
        
        .navigationBarItems(
            trailing: Button(action: { self.shouldPresentAddEmployeeSheet = true }) {
                Image("image_nb_add")
            }
        )
        
        .onAppear {
            self.employeesViewModel.fetchEmployees()
        }
    }
}

struct EmployeesView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeesView()
    }
}
