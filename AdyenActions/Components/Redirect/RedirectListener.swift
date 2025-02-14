//
// Copyright (c) 2022 Adyen N.V.
//
// This file is open source and available under the MIT license. See the LICENSE file for more info.
//

import Foundation

/// A typealias for a closure that handles a URL through which the application was opened.
@_spi(AdyenInternal)
public typealias URLHandler = (URL) throws -> Void

/// Listens for the return of the shopper after a redirect.
@_spi(AdyenInternal)
public enum RedirectListener {
    
    // MARK: - Registering for URLs
    
    /// Sets a handler that will be invoked when the application is opened.
    /// The handler will only be invoked once. Only one handler can be registered at the same time.
    ///
    /// - Parameter handler: The handler to invoke when the application is opened.
    public static func registerForURL(using handler: @escaping URLHandler) {
        urlHandler = handler
    }
    
    private static var urlHandler: URLHandler?
    
    // MARK: - Handling a URL
    
    /// Should be invoked when the application is opened through a URL.
    ///
    /// - Parameter url: The URL through which the application was opened.
    /// - Returns: A boolean value indicating whether the URL was handled by the RedirectListener.
    internal static func applicationDidOpen(from url: URL) throws -> Bool {
        guard let urlHandler else {
            return false
        }
        
        defer {
            self.urlHandler = nil
        }
        
        try urlHandler(url)
        
        return true
    }
    
}
