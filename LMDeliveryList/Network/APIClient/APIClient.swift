//
//  APIClient.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation

protocol APIClient {
  func executeRequest(
    parameters: ResourceParameters,
    completion: @escaping (Result<ApiResponseWrapper,ApiErrorWrapper>)-> Void
  )
}

final class APIClientImpl: APIClient {
  private var acceptableStatusCodes: Range<Int> { 200..<300 }
  private let sessionManager: URLSession
  private let baseURLString: String
  private let defaultTimeoutInterval: TimeInterval = 60
  private let requestEncoder: RequestEncoder

  init(
    requestEncoder: RequestEncoder,
    baseURLString: String = "https://6285f87796bccbf32d6c0e6a.mockapi.io",
    configuration: URLSessionConfiguration = .ephemeral
  ) {
    self.sessionManager = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    self.baseURLString = baseURLString
    self.requestEncoder = requestEncoder
  }

  func executeRequest(
    parameters: ResourceParameters,
    completion: @escaping (Result<ApiResponseWrapper, ApiErrorWrapper>) -> Void
  ) {
    let urlRequest: URLRequest
    do {
      urlRequest = try self.urlRequest(with: parameters)
      let task = self.sessionManager.dataTask(with: urlRequest) { data, response, error in
        let response = response as? HTTPURLResponse

        if let error = self.getErrorFromAPIResult(response: response, error: error) {
          let apiErrorWrapper = ApiErrorWrapper(
            httpResponse: response,
            httpError: error,
            jsonResponse: data
          )
          DispatchQueue.main.async {
            completion(.failure(apiErrorWrapper))
          }
        }
        else {
          let responseWrapper = ApiResponseWrapper(
            httpResponse: response,
            jsonResponse: data
          )
          DispatchQueue.main.async {
            completion(.success(responseWrapper))
          }
        }
      }

      task.resume()
    }
    catch let requestError {
      completion(
        .failure(
          ApiErrorWrapper(
            httpResponse: nil,
            httpError: requestError,
            jsonResponse: nil
          )
        )
      )
    }

  }

}

extension APIClientImpl {
  private func urlRequest(with parameters: ResourceParameters) throws -> URLRequest {
    // make URL
    let needSlash = !(baseURLString.hasSuffix("/") || parameters.path.hasPrefix("/"))
    let delimiter = needSlash ? "/" : ""
    let fullURLString = baseURLString + delimiter + parameters.path

    let components = URLComponents(string: fullURLString)
    let fullURL = components?.url

    guard let requestURL = fullURL else {
      let error = NSError(domain: "API.ERROR", code: NSURLErrorUnsupportedURL, userInfo: nil)
      throw error
    }

    var urlRequest = URLRequest(url: requestURL)
    urlRequest.httpMethod = parameters.httpMethod.rawValue
    urlRequest.allHTTPHeaderFields = parameters.headers

    let bodyFormat = parameters.bodyFormat

    if let requestBody = parameters.body {
      if bodyFormat == .JSON {
        urlRequest = try requestEncoder.encode(urlRequest, withJSONObject: requestBody)
      } else {
        urlRequest = try requestEncoder.encode(urlRequest, with: requestBody)
      }
    }
    urlRequest.timeoutInterval = defaultTimeoutInterval

    return urlRequest
  }
  
  private func getErrorFromAPIResult(response: HTTPURLResponse?, error: Error?) -> Error? {
    guard error == nil else {
      return error
    }
    let statusCode = response?.statusCode ?? -1
    guard acceptableStatusCodes.contains(statusCode) else {
      return NSError(domain: "API.ERROR", code: statusCode, userInfo: nil)
    }
    return nil
  }
}
