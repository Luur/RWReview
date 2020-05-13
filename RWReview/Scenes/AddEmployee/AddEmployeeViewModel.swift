//
//  AddEmployeeViewModel.swift
//  RWReview
//
//  Created by Svyat Zubyak on 13.05.2020.
//  Copyright © 2020 Svyat Zubyak. All rights reserved.
//

import UIKit
import SwiftUI
import Combine
import PhoneNumberKit

protocol AddEmployeeDelegate: class {
    func employeeCreated(_ employee: EmployeeViewModel)
}

extension AddEmployeeDelegate {
    func employeeCreated(_ employee: EmployeeViewModel) {}
}

class AddEmployeeViewModel: ObservableObject {
    
    private var employeesRepositoryProvider: EmployeesRepositoryProviderProtocol
    private var validator: Validator
    private var phoneNumberKit: PhoneNumberKitProtocol
    
    weak private var delegate: AddEmployeeDelegate?
    
    var encodableEmployee: EmployeeEncodableModel?
    
    @Published var selectedImage: UIImage?
    @Published var imageURL: URL?
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    
    @Published var startDate: Date? {
        didSet {
            startDateErrorDescription = nil
        }
    }
    
    @Published var birthDate: Date?
    
    @Published var isLoading: Bool = false
    @Published var alert: AlertData?
    @Published var shouldDismissView = false
    
    @Published var emailErrorDescription: String?
    @Published var firstNameErrorDescription: String?
    @Published var lastNameErrorDescription: String?
    @Published var phoneErrorDescription: String?
    @Published var startDateErrorDescription: String?
    
    init(
        delegate: AddEmployeeDelegate?,
        validator: Validator = Validator(),
        employeesRepositoryProvider: EmployeesRepositoryProviderProtocol = EmployeesRepositoryProvider(),
        phoneNumberKit: PhoneNumberKitProtocol = PhoneNumberKit()
    ) {
        self.delegate = delegate
        self.phoneNumberKit = phoneNumberKit
        self.validator = validator
        self.employeesRepositoryProvider = employeesRepositoryProvider
    }
    
    func validateInputs() {
        
        validateTextFields()
        validateSelectionFields()
        
        guard validationResult == .success else { return }
        
        configureEncodableEmployee()
        
        createEmployee()
    }
    
    var validationResult: Validator.ValidationResult {
        let errorDescriptions = [firstNameErrorDescription, lastNameErrorDescription, emailErrorDescription, phoneErrorDescription, startDateErrorDescription].compactMap { $0 }
        return errorDescriptions.isEmpty ? .success : .failure
    }
    
    func configureEncodableEmployee() {
        let nationalPhoneNumber = try? phoneNumberKit.parse(phone).nationalNumber
        encodableEmployee = EmployeeEncodableModel(firstName: firstName, lastName: lastName, startDate: startDate, birthDate: birthDate, email: email, phone: nationalPhoneNumber, image: selectedImage)
    }
    
    func validateTextFields() {
        
        let firstNameErrors = validator.validate(firstName, with: [RequiredValidationRule(error: EmployeeError.blankFirstName)])
        firstNameErrorDescription = firstNameErrors.first?.localizedDescription

        let lastNameErrors = validator.validate(lastName, with: [RequiredValidationRule(error: EmployeeError.blankLastName)])
        lastNameErrorDescription = lastNameErrors.first?.localizedDescription

        let emailErrors = validator.validate(email, with: [
            RequiredValidationRule(error: EmployeeError.blankEmail),
            EmailValidationRule(error: EmployeeError.invalidEmail)
        ])
        emailErrorDescription = emailErrors.first?.localizedDescription

        if !phone.isEmpty {
            let phoneErrors = validator.validate(phone, with: [PhoneNumberValidationRule(error: EmployeeError.invalidPhone)])
            phoneErrorDescription = phoneErrors.first?.localizedDescription
        }
    }
    
    func validateSelectionFields() {
        startDateErrorDescription = startDate == nil ? EmployeeError.startDateNotSelected.localizedDescription : nil
    }
    
    func createEmployee() {
        
        guard !isLoading else { return }
        guard let encodableEmployee = self.encodableEmployee else { return }
        
        isLoading = true
        
        let repository = employeesRepositoryProvider.getEmployeesRepository()
        repository.createEmployee(encodableEmployee) { [weak self] result in
            self?.isLoading = false
            switch(result) {
            case .success(let employee):
                self?.delegate?.employeeCreated(EmployeeViewModel(employee: employee))
                self?.shouldDismissView = true
            case .failure(let error) :
                self?.alert = AlertData(message: error.localizedDescription)
            }
        }
    }
}
