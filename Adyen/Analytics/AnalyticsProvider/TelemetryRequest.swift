//
// Copyright (c) 2022 Adyen N.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

import AdyenNetworking
import Foundation

/// :nodoc:
internal struct TelemetryResponse: Response { /* Empty response */ }

/// :nodoc:
internal struct TelemetryRequest: APIRequest {

    /// :nodoc:
    internal typealias ResponseType = TelemetryResponse

    /// :nodoc:
    internal let path: String = "checkoutshopper/v2/analytics/log"

    /// :nodoc:
    internal var counter: UInt = 0

    /// :nodoc:
    internal let headers: [String: String] = [:]

    /// :nodoc:
    internal let queryParameters: [URLQueryItem] = []

    /// :nodoc:
    internal let method: HTTPMethod = .post

    private let version: String?
    private let channel: String
    private let locale: String
    private let flavor: String
    private let userAgent: String?
    private let deviceBrand: String
    private let systemVersion: String
    private let referrer: String
    private let screenWidth: Int
    private let containerWidth: Int?
    private let paymentMethods: [String]
    private let component: String
    private let checkoutAttemptId: String?

    // MARK: - Initializers

    internal init(data: TelemetryData, checkoutAttemptId: String?) {
        self.version = data.version
        self.channel = data.channel
        self.locale = data.locale
        self.flavor = data.flavor
        self.userAgent = data.userAgent
        self.deviceBrand = data.deviceBrand
        self.systemVersion = data.systemVersion
        self.referrer = data.referrer
        self.screenWidth = data.screenWidth
        self.containerWidth = data.containerWidth
        self.paymentMethods = data.paymentMethods
        self.component = data.component
        self.checkoutAttemptId = checkoutAttemptId
    }

    internal enum CodingKeys: CodingKey {
        case version
        case channel
        case locale
        case flavor
        case userAgent
        case deviceBrand
        case systemVersion
        case referrer
        case screenWidth
        case containerWidth
        case paymentMethods
        case component
        case checkoutAttemptId
    }
}
