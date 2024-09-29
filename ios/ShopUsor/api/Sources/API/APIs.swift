// APIs.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
open class APIAPI {
   // public static var basePath = "http://172.31.72.163:3000"
    public static var basePath = "https://89e0-77-89-208-34.ngrok-free.app"
    public static var customHeaders: [String: String] = [:]
    public static var credential: URLCredential?
    public static var requestBuilderFactory: RequestBuilderFactory = URLSessionRequestBuilderFactory()
    public static var apiResponseQueue: DispatchQueue = .main
}

open class RequestBuilder<T> {
    var credential: URLCredential?
    var headers: [String: String]
    public let parameters: [String: Any]?
    public let method: String
    public let URLString: String
    public let requestTask: RequestTask = RequestTask()
    public let requiresAuthentication: Bool

    /// Optional block to obtain a reference to the request's progress instance when available.
    public var onProgressReady: ((Progress) -> Void)?

    required public init(method: String, URLString: String, parameters: [String: Any]?, headers: [String: String] = [:], requiresAuthentication: Bool) {
        self.method = method
        self.URLString = URLString
        self.parameters = parameters
        self.headers = headers
        self.requiresAuthentication = requiresAuthentication

        addHeaders(APIAPI.customHeaders)
    }

    open func addHeaders(_ aHeaders: [String: String]) {
        for (header, value) in aHeaders {
            headers[header] = value
        }
    }

    @discardableResult
    open func execute(_ apiResponseQueue: DispatchQueue = APIAPI.apiResponseQueue, _ completion: @escaping (_ result: Swift.Result<Response<T>, ErrorResponse>) -> Void) -> RequestTask {
        return requestTask
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    @discardableResult
    open func execute() async throws -> Response<T> {
        return try await withTaskCancellationHandler {
            try Task.checkCancellation()
            return try await withCheckedThrowingContinuation { continuation in
                guard !Task.isCancelled else {
                  continuation.resume(throwing: CancellationError())
                  return
                }

                self.execute { result in
                    print(result)
                    switch result {
                    case let .success(response):
                        continuation.resume(returning: response)
                    case let .failure(error):
                        if case let .error(code, data, response, error) = error {
                            if let data = data {
                               // print(String(data: data, encoding: .utf8))
                            }
                        }
                        continuation.resume(throwing: error)
                    }
                }
            }
        } onCancel: {
            self.requestTask.cancel()
        }
    }
    
    public func addHeader(name: String, value: String) -> Self {
        if !value.isEmpty {
            headers[name] = value
        }
        return self
    }

    open func addCredential() -> Self {
        credential = APIAPI.credential
        return self
    }
}

public protocol RequestBuilderFactory {
    func getNonDecodableBuilder<T>() -> RequestBuilder<T>.Type
    func getBuilder<T: Decodable>() -> RequestBuilder<T>.Type
}
