import Foundation
import Domain

public final class LoginPresenter {
    private let alertView: AlertView
    private let authentication: Authentication
    private let loadingView: LoadingView
    private let validation: Validation
    
    public init(
        alertView: AlertView,
        authentication: Authentication,
        loadingView: LoadingView,
        validation: Validation
    ) {
        self.alertView = alertView
        self.authentication = authentication
        self.loadingView = loadingView
        self.validation = validation
    }
    
    public func login(viewModel: LoginViewModel) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            authentication.auth(authenticationModel: viewModel.toAuthenticationModel()) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    let errorMessage: String
                    switch error {
                    case .emailInUse:
                        errorMessage = "Esse Email já está em uso"
                    default:
                        errorMessage = "Algo inesperado aconteceu, tente novamente em alguns instantes"
                    }
                    
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: errorMessage))
                case .success:
                    let alertViewModel = AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso.")
                    self.alertView.showMessage(viewModel: alertViewModel)
                    break
                }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            }
        }
    }
}
