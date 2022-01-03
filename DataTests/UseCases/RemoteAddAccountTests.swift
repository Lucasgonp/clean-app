import XCTest
import Domain
import Data

class RemoteAddAccountTests: XCTestCase {
    func test_add_should_call_http_client_with_correct_url() throws {
        let url = try XCTUnwrap(URL(string: "hrrp://any-url.com"))
        let (sut, httpClientSpy) = makeSut(url: url)
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel, httpClient: httpClientSpy)
        XCTAssertEqual(httpClientSpy.url, [url])
    }
    
    func test_add_should_call_http_client_with_correct_data() throws {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel, httpClient: httpClientSpy)
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
}

extension RemoteAddAccountTests {
    func makeSut(url: URL = URL(string: "hrrp://any-url.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "any_name", email: "any_email@mail.com", password: "any_password", passwordConfirmation: "any_password")
    }
    
    class HttpClientSpy: HttpPostClient {
        var url = [URL?]()
        var data: Data?
        
        func post(to url: URL, with data: Data?) {
            self.url.append(url)
            self.data = data
        }
    }
}