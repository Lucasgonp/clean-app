import Foundation
import Domain

public final class RemoteAuthentication {
    private let url: URL
    private let httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func auth(authenticationModel: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
        httpClient.post(to: url, with: authenticationModel.toData()) {  result in
            switch result {
            case let .success(data):
                break
//                if let model: AccountModel = data?.toModel() {
//                    completion(.success(model))
//                } else {
//                    completion(.failure(.unexpected))
//                }
            case .failure(let error):
                completion(.failure(.unexpected))
//                switch error {
//                case .forbidden:
//                    completion(.failure(.emailInUse))
//                default:
//                    completion(.failure(.unexpected))
//                }
            }
        }
    }
}
