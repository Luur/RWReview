//
//  EmployeesViewModel.swift
//  RWReview
//
//  Created by Svyat Zubyak on 12.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import Foundation
import SwiftUI

class EmployeesViewModel: ObservableObject {
    
    private var employeesRepositoryProvider: EmployeesRepositoryProviderProtocol
    var employees: [EmployeeViewModel] = []
    
    @Published var activeEmployees: [EmployeeViewModel] = []
    @Published var inactiveEmployees: [EmployeeViewModel] = []
    @Published var isLoading: Bool = false
    @Published var alert: AlertData?
    
    init(employeesRepositoryProvider: EmployeesRepositoryProviderProtocol = EmployeesRepositoryProvider()) {
        self.employeesRepositoryProvider = employeesRepositoryProvider
    }
    
    func fetchEmployees() {
        isLoading = true
        let repository = employeesRepositoryProvider.getEmployeesRepository()
        repository.fetchEmployees() { [weak self] result in
            self?.isLoading = false
            switch(result) {
            case .success(let employees):
                self?.employees = employees.map(EmployeeViewModel.init)
                self?.filterEmployees()
            case .failure(let error) :
                self?.alert = AlertData(message: error.localizedDescription)
            }
        }
    }
    
    private func filterEmployees() {
        activeEmployees = employees.filter { $0.isActive }
        inactiveEmployees = employees.filter { !$0.isActive }
    }
}

extension EmployeesViewModel: AddEmployeeDelegate {
    
    func employeeCreated(_ employee: EmployeeViewModel) {
        employees.append(employee)
        guard NSClassFromString("XCTestCase") == nil else { return }
        filterEmployees()
    }
}
