import Data
import Domain
import Foundation

func makeRemoteAuthentication() -> Authentication {
    return makeRemoteAuthenticationWith(httpClient: makeAlamofireAdapter())
}

func makeRemoteAuthenticationWith(httpClient: HttpPostClient) -> Authentication {
    let remoteAuthentication = RemoteAuthentication(url: makeApiUrl(path: "login"), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAuthentication)
}
