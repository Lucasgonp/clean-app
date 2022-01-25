import XCTest
import Presentation
import UIKit
@testable import UI

class LoginViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() throws {
        XCTAssertEqual(makeSut().activityIndicator?.isAnimating, false)
    }
    
//    func test_sut_implements_loadingView() throws {
//        XCTAssertNotNil(makeSut() as LoadingView)
//    }
//
//    func test_sut_implements_alertView() throws {
//        XCTAssertNotNil(makeSut() as AlertView)
//    }
//
//    func test_save_button_calls_signUp_on_tap() throws {
//        var signUpViewModel: SignUpViewModel?
//        let sut = makeSut(signUpSpy: { signUpViewModel = $0 })
//        sut.saveButton?.simulateTap()
//        let name = sut.nameTextField?.text
//        let email = sut.emailTextField?.text
//        let password = sut.passwordTextField?.text
//        let passwordConfirmation = sut.confirmPasswordField?.text
//        XCTAssertEqual(signUpViewModel, SignUpViewModel(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation))
//    }
}

extension LoginViewControllerTests {
    func makeSut(loginSpy: ((LoginViewModel) -> Void)? = nil) -> LoginViewController {
        let sut = LoginViewController.instantiate()
        //sut.login = loginSpy
        sut.loadViewIfNeeded()
        return sut
    }
}