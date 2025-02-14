//
// Copyright (c) 2023 Adyen N.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

@_spi(AdyenInternal) import Adyen
import AdyenNetworking
import AdyenSession

internal protocol InitialDataFlowProtocol: AnyObject {
    var context: AdyenContext { get }
    var apiClient: APIClientProtocol { get }
    func requestAdyenSessionConfiguration(completion: @escaping (Result<AdyenSession.Configuration, Error>) -> Void)
}

extension InitialDataFlowProtocol {

    internal var context: AdyenContext {
        var analyticsConfiguration = AnalyticsConfiguration()
        analyticsConfiguration.isEnabled = ConfigurationConstants.current.analyticsSettings.isEnabled
        return AdyenContext(apiContext: ConfigurationConstants.apiContext,
                            payment: ConfigurationConstants.current.payment,
                            analyticsConfiguration: analyticsConfiguration)
    }

    internal func requestAdyenSessionConfiguration(completion: @escaping (Result<AdyenSession.Configuration, Error>) -> Void) {
        let request = SessionRequest()
        apiClient.perform(request) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                let config = self.initializeSession(with: response.sessionId, data: response.sessionData)
                completion(.success(config))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func initializeSession(with sessionId: String, data: String) -> AdyenSession.Configuration {
        let configuration = AdyenSession.Configuration(
            sessionIdentifier: sessionId,
            initialSessionData: data,
            context: context,
            actionComponent: .init(
                threeDS: .init(
                    requestorAppURL: URL(string: ConfigurationConstants.returnUrl),
                    delegateAuthentication: ConfigurationConstants.delegatedAuthenticationConfigurations
                )
            )
        )
        return configuration
    }
}

extension SessionPaymentResultCode {
    var isSuccess: Bool {
        self == .authorised || self == .received || self == .pending
    }
}
