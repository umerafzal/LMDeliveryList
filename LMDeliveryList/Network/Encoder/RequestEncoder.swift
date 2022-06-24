//
//  RequestEncoder.swift
//  LMDeliveryList
//
//  Created by Umer Afzal on 24/06/2022.
//

import Foundation

protocol RequestEncoder {
  func encode(_ urlRequest: URLRequest, withJSONObject jsonObject: Any) throws -> URLRequest
  func encode(_ urlRequest: URLRequest, with parameters: [String: Any]) throws -> URLRequest
}

final class RequestEncoderImpl: RequestEncoder {
  private static let apiURLQueryAllowed: CharacterSet = {
    let delimiters = ":#[]@!$&'()*+,;="
    let encodableDelimiters = CharacterSet(charactersIn: delimiters)
    return CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
  }()

  func encode(_ urlRequest: URLRequest, withJSONObject jsonObject: Any) throws -> URLRequest {
    var urlRequest = urlRequest

    let data = try JSONSerialization.data(withJSONObject: jsonObject)
    urlRequest.httpBody = data
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

    return urlRequest
  }

  func encode(_ urlRequest: URLRequest, with parameters: [String: Any]) throws -> URLRequest {
    var urlRequest = urlRequest

    if let method = urlRequest.httpMethod, shouldEncodesParameters(method: method) {
      guard let url = urlRequest.url else {
        let error = NSError(domain: "API.ERROR", code: NSURLErrorUnsupportedURL, userInfo: nil)
        throw error
      }
      if var components = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
        var percentEncodedQuery = components.percentEncodedQuery.map { $0 + "&" } ?? ""
        percentEncodedQuery += makeQuery(parameters: parameters)
        components.percentEncodedQuery = percentEncodedQuery
        urlRequest.url = components.url
      }
    } else {
      urlRequest.httpBody = Data(makeQuery(parameters: parameters).utf8)
      urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
    }

    return urlRequest
  }
}

// MARK: - Private methods

extension RequestEncoderImpl {
  private func shouldEncodesParameters(method: String) -> Bool {
    ["GET", "HEAD", "DELETE"].contains(method)
  }

  private func makeQuery(parameters: [String: Any]) -> String {
    var components = [String]()

    let sortedKeys = parameters.keys.sorted(by: <)
    for key in sortedKeys {
      if let value = parameters[key] {
        components += makeQueryComponents(key: key, value: value)
      }
    }

    return components.joined(separator: "&")
  }

  private func makeQueryComponents(key: String, value: Any) -> [String] {
    var components = [String]()

    if let value = value as? Bool {
      components.append(boolComponent(key: key, value: value))
    } else {
      components.append(stringComponent(key: key, value: value))
    }

    return components
  }

  private func boolComponent(key: String, value: Bool) -> String {
    let bool = value ? "1" : "0"
    return "\(escape(key))=\(bool)"
  }

  private func stringComponent(key: String, value: Any) -> String {
    let string = escape("\(value)")
    return "\(escape(key))=\(string)"
  }

  private func escape(_ string: String) -> String {
    guard let encoded = string.addingPercentEncoding(withAllowedCharacters: RequestEncoderImpl.apiURLQueryAllowed)
    else { return string }
    return encoded
  }
}
