import XCTest
import Presentation
import Data
import Domain
@testable import DataTests

class SignUpPresenterTests: XCTestCase {
    func test_signUp_should_show_error_message_if_name_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let signUpViewModel = makeSignUpViewModel(name: nil)
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldName: "Nome"))
    }
    
    func test_signUp_should_show_error_message_if_email_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let signUpViewModel = makeSignUpViewModel(email: nil)
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldName: "Email"))
    }
    
    func test_signUp_should_show_error_message_if_password_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let signUpViewModel = makeSignUpViewModel(password: nil)
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldName: "Senha"))
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let signUpViewModel = makeSignUpViewModel(passwordConfirmation: nil)
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldName: "Confirmação de senha"))
    }
    
    func test_signUp_should_show_error_message_if_password_confirmation_not_match() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let signUpViewModel = makeSignUpViewModel(password: "any_password", passwordConfirmation: "wrong_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, makeInvalidAlertViewModel(fieldName: "Confirmação de senha"))
    }
    
    func test_signUp_should_show_error_message_if_invalid_email_is_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(alertViewSpy.viewModel, makeInvalidAlertViewModel(fieldName: "Email"))
    }
    
    func test_signUp_should_call_email_validator_with_correct_email() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidator: emailValidatorSpy)
        let signUpViewModel = makeSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }
    
    func test_signUp_should_call_addAccount_with_correct_values() throws {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }
}

extension SignUpPresenterTests {
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), emailValidator: EmailValidatorSpy = EmailValidatorSpy(), addAccount: AddAccountSpy = AddAccountSpy()) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidator, addAccount: addAccount)
        return sut
    }
    
    func makeSignUpViewModel(name: String? = "any_name", email: String? = "any_email@mail.com", password: String? = "any_password", passwordConfirmation: String? = "any_password") -> SignUpViewModel {
        return SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    
    func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação do titulo", message: "O campo \(fieldName) é obrigatório")
    }
    
    func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação do titulo", message: "O campo \(fieldName) é inválido")
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
    
    class EmailValidatorSpy: EmailValidator {
        var isValid: Bool = true
        var email: String?
        
        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
        }
        
        func simulateInvalidEmail() {
            self.isValid = false
        }
    }
    
    class AddAccountSpy: AddAccount {
        var addAccountModel: AddAccountModel?
        
        func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
        }
    }
}
