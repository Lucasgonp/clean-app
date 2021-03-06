import Foundation
import Presentation
import UIKit

public final class SignUpViewController: UIViewController, StoryBoarded {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    public var signUp: ((SignUpRequest) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "Cadastrar"
        saveButton.layer.cornerRadius = 5
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        hideKeyboardOnTap()
    }
    
    @objc
    private func saveButtonTapped() {
        let viewModel = SignUpRequest(name: nameTextField.text, email: emailTextField.text, password: passwordTextField.text, passwordConfirmation: confirmPasswordField.text)
        signUp?(viewModel)
    }
}

extension SignUpViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            activityIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            activityIndicator.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alertView = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertView, animated: true)
    }
}
